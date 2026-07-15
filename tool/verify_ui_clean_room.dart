import 'dart:io';

const _mainBaseline = 'f34dbd5221b71a8539e7fac8559602ade876ed23';

const _glassRefs = <_GlassRef>[
  _GlassRef(
    name: 'feature-glass-like',
    ref: 'feature-glass-like',
    frozenTip: 'bf74e2ca9848c7dcb8e325c313e42aae46234880',
  ),
  _GlassRef(
    name: 'origin/feature-glass-like',
    ref: 'origin/feature-glass-like',
    frozenTip: 'ed3d2df1cac27f5c6b59b1838cf1d1de0274c317',
  ),
];

const _forbiddenRuntimeMarkers = <String>[
  'BackdropFilter',
  'ImageFilter.blur',
  'MusicChrome',
  'MusicGlassSurface',
  'MusicGradientBackdrop',
  'MusicChromeTheme',
  'glassBlur',
];

const _legacyPressStateMarkers = <String>[
  '_pressed',
  '_setPressed(',
  'AnimatedScale(',
  'onTapDown:',
  'onTapUp:',
  'onTapCancel:',
];

const _lineWindowSize = 3;
const _tokenWindowSize = 36;
const _canonicalTokenWindowSize = 52;

final _hunkHeader = RegExp(r'^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@');
final _syntaxOnly = RegExp(r'^[{}\[\](),.;:]+$');
final _tokenPattern = RegExp(
  r'[A-Za-z_]\w*|\d+(?:\.\d+)?|==|!=|=>|\?\?|\?\.|&&|\|\||<=|>=|\.\.\.|[{}()\[\].,;:+\-*/%!?<>]=?',
);

Future<void> main() async {
  final root = (await _gitText(<String>[
    'rev-parse',
    '--show-toplevel',
  ])).trim();
  Directory.current = root;

  final missingRefs = <String>[];
  final refDrift = <String>[];
  final ancestryViolations = <String>[];
  final patchViolations = <String>[];
  final lineWindowOrigins = <String, List<_Origin>>{};
  final tokenWindowOrigins = <int, List<_TokenOrigin>>{};
  final canonicalTokenWindowOrigins = <int, List<_TokenOrigin>>{};

  if (!await _gitObjectExists(_mainBaseline)) {
    stderr.writeln(
      'Clean-room audit cannot run: missing frozen main baseline '
      '$_mainBaseline.',
    );
    exitCode = 2;
    return;
  }

  final mainSources = await _readTreeSources(_mainBaseline);
  final mainLines = <String>{
    for (final source in mainSources.values)
      for (final line in source.split('\n'))
        if (_isSubstantive(line)) _normalizeLine(line),
  };
  final mainTokenHashes = _treeTokenHashes(
    mainSources,
    size: _tokenWindowSize,
    canonical: false,
  );
  final mainCanonicalTokenHashes = _treeTokenHashes(
    mainSources,
    size: _canonicalTokenWindowSize,
    canonical: true,
  );

  final processedCommits = <String>{};

  for (final glassRef in _glassRefs) {
    if (!await _gitObjectExists(glassRef.ref)) {
      missingRefs.add(glassRef.ref);
      continue;
    }
    if (!await _gitObjectExists(glassRef.frozenTip)) {
      missingRefs.add('${glassRef.name}@${glassRef.frozenTip}');
      continue;
    }

    final liveTip = (await _gitText(<String>[
      'rev-parse',
      glassRef.ref,
    ])).trim();
    if (liveTip != glassRef.frozenTip) {
      refDrift.add(
        '${glassRef.name}: expected ${glassRef.frozenTip}, found $liveTip',
      );
    }

    final tips = <String>{glassRef.frozenTip, liveTip};
    for (final tip in tips) {
      final base = (await _gitText(<String>[
        'merge-base',
        _mainBaseline,
        tip,
      ])).trim();
      final commits = (await _gitText(<String>[
        'rev-list',
        '--reverse',
        '$base..$tip',
      ])).split('\n').where((line) => line.isNotEmpty);

      final cherry = await _git(<String>['cherry', 'HEAD', tip, base]);
      if (cherry.exitCode == 0) {
        for (final line in _normalizedOutput(cherry.stdout).split('\n')) {
          if (!line.startsWith('- ') || line.length < 42) continue;
          final commit = line.substring(2, 42);
          if (await _commitTouchesUi(commit)) {
            patchViolations.add('${glassRef.name}: $commit');
          }
        }
      }

      for (final commit in commits) {
        if (!await _commitTouchesUi(commit)) continue;

        final ancestor = await _git(<String>[
          'merge-base',
          '--is-ancestor',
          commit,
          'HEAD',
        ]);
        if (ancestor.exitCode == 0) {
          ancestryViolations.add('${glassRef.name}: $commit');
        }

        if (!processedCommits.add(commit)) continue;
        final origin = '${glassRef.name}@${commit.substring(0, 12)}';
        final regions = await _glassPatchRegions(
          commit: commit,
          mainLines: mainLines,
        );
        for (final region in regions) {
          if (region.lines.length >= _lineWindowSize) {
            for (
              var index = 0;
              index <= region.lines.length - _lineWindowSize;
              index++
            ) {
              final window = region.lines
                  .skip(index)
                  .take(_lineWindowSize)
                  .map((line) => line.text)
                  .join('\u0000');
              lineWindowOrigins
                  .putIfAbsent(window, () => <_Origin>[])
                  .add(
                    _Origin(origin, region.path, region.lines[index].number),
                  );
            }
          }

          _addTokenWindows(
            region.source,
            ref: origin,
            path: region.path,
            line: region.lines.first.number,
            size: _tokenWindowSize,
            canonical: false,
            excludedHashes: mainTokenHashes,
            target: tokenWindowOrigins,
          );
          _addTokenWindows(
            region.source,
            ref: origin,
            path: region.path,
            line: region.lines.first.number,
            size: _canonicalTokenWindowSize,
            canonical: true,
            excludedHashes: mainCanonicalTokenHashes,
            target: canonicalTokenWindowOrigins,
          );
        }
      }
    }
  }

  if (missingRefs.isNotEmpty) {
    stderr.writeln(
      'Clean-room audit cannot run: missing Git refs ${missingRefs.join(', ')}.',
    );
    exitCode = 2;
    return;
  }

  final currentFiles =
      Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .where((file) => _isUiPath(_slash(file.path)))
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));

  final sequenceMatches = <String>[];
  final tokenMatches = <String>[];
  final structuralMatches = <String>[];
  final runtimeMarkers = <String>[];

  for (final file in currentFiles) {
    final path = _slash(file.path);
    final source = file.readAsStringSync();
    final lines = source.split(RegExp(r'\r?\n'));
    final substantive = <_CurrentLine>[];

    for (var index = 0; index < lines.length; index++) {
      final raw = lines[index];
      if (!_isSubstantive(raw)) continue;
      final normalized = _normalizeLine(raw);
      substantive.add(_CurrentLine(index + 1, normalized));
    }

    if (substantive.length >= _lineWindowSize) {
      for (
        var index = 0;
        index <= substantive.length - _lineWindowSize;
        index++
      ) {
        final window = substantive
            .skip(index)
            .take(_lineWindowSize)
            .map((line) => line.text)
            .join('\u0000');
        final origins = lineWindowOrigins[window];
        if (origins == null) continue;
        sequenceMatches.add(
          '$path:${substantive[index].number} matches ${_originSummary(origins)}',
        );
      }
    }

    _findTokenMatches(
      source,
      path: path,
      size: _tokenWindowSize,
      canonical: false,
      origins: tokenWindowOrigins,
      output: tokenMatches,
    );
    _findTokenMatches(
      source,
      path: path,
      size: _canonicalTokenWindowSize,
      canonical: true,
      origins: canonicalTokenWindowOrigins,
      output: tokenMatches,
    );

    if (path.startsWith('lib/core/design/components/') &&
        _legacyPressStateMarkers.every(source.contains)) {
      structuralMatches.add(
        '$path: legacy _pressed/_setPressed GestureDetector state machine',
      );
    }

    for (final marker in _forbiddenRuntimeMarkers) {
      if (source.contains(marker)) runtimeMarkers.add('$path: $marker');
    }
  }

  final hasViolations =
      refDrift.isNotEmpty ||
      ancestryViolations.isNotEmpty ||
      patchViolations.isNotEmpty ||
      sequenceMatches.isNotEmpty ||
      tokenMatches.isNotEmpty ||
      structuralMatches.isNotEmpty ||
      runtimeMarkers.isNotEmpty;

  if (!hasViolations) {
    stdout.writeln(
      'Clean-room audit passed: frozen Glasslike histories are absent, the '
      'frozen main baseline is excluded, and no cross-path fingerprints or '
      'forbidden runtime markers remain.',
    );
    return;
  }

  _printSection('Glasslike refs moved after the provenance freeze:', refDrift);
  _printSection(
    'Glasslike UI commits present in HEAD ancestry:',
    ancestryViolations,
  );
  _printSection('Patch-equivalent Glasslike UI commits:', patchViolations);
  _printSection('Cross-path Glasslike line sequences:', sequenceMatches);
  _printSection('Cross-path Glasslike token fingerprints:', tokenMatches);
  _printSection('Legacy mechanical-derivative structures:', structuralMatches);
  _printSection('Forbidden Glass/MusicChrome runtime markers:', runtimeMarkers);
  exitCode = 1;
}

Future<List<_PatchRegion>> _glassPatchRegions({
  required String commit,
  required Set<String> mainLines,
}) async {
  final patch = await _gitText(<String>[
    'show',
    '--format=',
    '--no-ext-diff',
    '--no-renames',
    '--unified=0',
    commit,
    '--',
    ':(glob)lib/**/*.dart',
  ]);
  final regions = <_PatchRegion>[];
  var current = <_OwnedLine>[];
  var path = '';
  var lineNumber = 0;
  var inHunk = false;

  void closeRegion() {
    if (current.isNotEmpty && _isUiPath(path)) {
      regions.add(_PatchRegion(path, List<_OwnedLine>.of(current)));
    }
    current = <_OwnedLine>[];
  }

  for (final line in patch.split('\n')) {
    if (line.startsWith('diff --git ')) {
      closeRegion();
      path = '';
      inHunk = false;
      continue;
    }
    if (line.startsWith('+++ b/')) {
      closeRegion();
      path = line.substring(6);
      continue;
    }
    final header = _hunkHeader.firstMatch(line);
    if (header != null) {
      closeRegion();
      lineNumber = int.parse(header.group(1)!);
      inHunk = true;
      continue;
    }
    if (!inHunk || path.isEmpty) {
      continue;
    }

    if (line.startsWith('+') && !line.startsWith('+++')) {
      final source = line.substring(1);
      final normalized = _normalizeLine(source);
      if (_isSubstantive(source) && !mainLines.contains(normalized)) {
        current.add(_OwnedLine(lineNumber, normalized, source));
      }
      lineNumber++;
      continue;
    }
    if (line.startsWith('-') && !line.startsWith('---')) {
      continue;
    }

    if (line.startsWith(' ')) {
      lineNumber++;
    } else {
      closeRegion();
      inHunk = false;
    }
  }
  closeRegion();
  return regions;
}

Future<Map<String, String>> _readTreeSources(String ref) async {
  final sources = <String, String>{};
  final paths = (await _gitText(<String>[
    'ls-tree',
    '-r',
    '--name-only',
    ref,
    'lib',
  ])).split('\n').where((path) => path.endsWith('.dart'));
  for (final path in paths) {
    sources[path] = await _gitText(<String>['show', '$ref:$path']);
  }
  return sources;
}

Set<int> _treeTokenHashes(
  Map<String, String> sources, {
  required int size,
  required bool canonical,
}) {
  final hashes = <int>{};
  for (final source in sources.values) {
    final tokens = _tokens(source, canonical: canonical);
    for (var index = 0; index <= tokens.length - size; index++) {
      if (!_usefulTokenWindow(tokens, index, size)) continue;
      hashes.add(_tokenHash(tokens, index, size));
    }
  }
  return hashes;
}

void _addTokenWindows(
  String source, {
  required String ref,
  required String path,
  required int line,
  required int size,
  required bool canonical,
  required Set<int> excludedHashes,
  required Map<int, List<_TokenOrigin>> target,
}) {
  final tokens = _tokens(source, canonical: canonical);
  for (var index = 0; index <= tokens.length - size; index++) {
    if (!_usefulTokenWindow(tokens, index, size)) continue;
    final hash = _tokenHash(tokens, index, size);
    if (excludedHashes.contains(hash)) continue;
    final fingerprint = tokens.skip(index).take(size).join('\u0001');
    target
        .putIfAbsent(hash, () => <_TokenOrigin>[])
        .add(_TokenOrigin(ref, path, line, fingerprint, canonical));
  }
}

void _findTokenMatches(
  String source, {
  required String path,
  required int size,
  required bool canonical,
  required Map<int, List<_TokenOrigin>> origins,
  required List<String> output,
}) {
  final tokens = _tokens(source, canonical: canonical);
  final reported = <String>{};
  for (var index = 0; index <= tokens.length - size; index++) {
    if (!_usefulTokenWindow(tokens, index, size)) continue;
    final hash = _tokenHash(tokens, index, size);
    final candidates = origins[hash];
    if (candidates == null) continue;
    final fingerprint = tokens.skip(index).take(size).join('\u0001');
    for (final candidate in candidates) {
      if (candidate.fingerprint != fingerprint) continue;
      final key = '$path|${candidate.ref}|${candidate.path}|$canonical';
      if (!reported.add(key)) continue;
      output.add(
        '$path matches ${candidate.ref}:${candidate.path}:${candidate.line} '
        '(${canonical ? 'canonical' : 'exact'} tokens)',
      );
    }
  }
}

List<String> _tokens(String source, {required bool canonical}) {
  final withoutComments = source
      .replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), ' ')
      .replaceAll(RegExp(r'//[^\n]*'), ' ');
  return _tokenPattern
      .allMatches(withoutComments)
      .map((match) => match.group(0)!)
      .map(canonical ? _canonicalToken : (token) => token)
      .toList();
}

String _canonicalToken(String token) {
  if (!RegExp(r'^[A-Za-z_]\w*$').hasMatch(token)) return token;
  var result = token;
  if (result.startsWith('_')) {
    result = result.substring(1);
  }
  for (final prefix in <String>['Music', 'Echo', 'music', 'echo']) {
    if (result.startsWith(prefix) && result.length > prefix.length) {
      result = result.substring(prefix.length);
      break;
    }
  }
  result = result.replaceAll('Glass', '').replaceAll('Chrome', '');
  result = result.replaceAll('glass', '').replaceAll('chrome', '');
  return result.isEmpty ? 'Ui' : result;
}

bool _usefulTokenWindow(List<String> tokens, int start, int size) {
  final identifiers = <String>[];
  for (var index = start; index < start + size; index++) {
    final token = tokens[index];
    if (RegExp(r'^[A-Za-z_]\w*$').hasMatch(token)) identifiers.add(token);
  }
  return identifiers.length >= size ~/ 3 && identifiers.toSet().length >= 8;
}

int _tokenHash(List<String> tokens, int start, int size) {
  var hash = 0x14650FB0739D0383;
  for (var index = start; index < start + size; index++) {
    for (final unit in tokens[index].codeUnits) {
      hash ^= unit;
      hash = (hash * 0x100000001B3) & 0x7FFFFFFFFFFFFFFF;
    }
    hash ^= 31;
    hash = (hash * 0x100000001B3) & 0x7FFFFFFFFFFFFFFF;
  }
  return hash;
}

Future<bool> _commitTouchesUi(String commit) async {
  final paths = (await _gitText(<String>[
    'diff-tree',
    '--no-commit-id',
    '--name-only',
    '-r',
    commit,
    '--',
    ':(glob)lib/**/*.dart',
  ])).split('\n');
  return paths.any(_isUiPath);
}

bool _isUiPath(String path) {
  final normalized = _slash(path);
  if (!normalized.endsWith('.dart')) return false;
  return normalized == 'lib/app.dart' ||
      normalized == 'lib/providers/palette_provider.dart' ||
      normalized == 'lib/providers/theme_provider.dart' ||
      normalized.startsWith('lib/widgets/') ||
      normalized.startsWith('lib/core/theme/') ||
      normalized.startsWith('lib/core/design/') ||
      RegExp(r'^lib/features/[^/]+/(?:pages|widgets)/').hasMatch(normalized);
}

bool _isSubstantive(String source) {
  final line = _normalizeLine(source);
  if (line.length < 12 || _syntaxOnly.hasMatch(line)) return false;
  if (line.startsWith('import ') ||
      line.startsWith('export ') ||
      line.startsWith('part ') ||
      line.startsWith('//') ||
      line.startsWith('///')) {
    return false;
  }
  return true;
}

String _normalizeLine(String source) =>
    source.trim().replaceAll(RegExp(r'\s+'), ' ');

String _originSummary(List<_Origin> origins) {
  final unique = <String>{
    for (final origin in origins) '${origin.ref}:${origin.path}:${origin.line}',
  }.toList()..sort();
  return unique.take(3).join(', ');
}

void _printSection(String title, List<String> values) {
  if (values.isEmpty) return;
  stderr.writeln(title);
  for (final value in values.toSet().toList()..sort()) {
    stderr.writeln('  $value');
  }
}

Future<bool> _gitObjectExists(String object) async {
  final result = await _git(<String>['cat-file', '-e', object]);
  return result.exitCode == 0;
}

Future<ProcessResult> _git(List<String> arguments) {
  return Process.run('git', arguments);
}

Future<String> _gitText(List<String> arguments) async {
  final result = await _git(arguments);
  if (result.exitCode != 0) {
    throw ProcessException(
      'git',
      arguments,
      result.stderr.toString(),
      result.exitCode,
    );
  }
  return _normalizedOutput(result.stdout);
}

String _normalizedOutput(Object? output) =>
    output.toString().replaceAll('\r\n', '\n');

String _slash(String path) => path.replaceAll('\\', '/');

class _Origin {
  const _Origin(this.ref, this.path, this.line);

  final String ref;
  final String path;
  final int line;
}

class _TokenOrigin extends _Origin {
  const _TokenOrigin(
    super.ref,
    super.path,
    super.line,
    this.fingerprint,
    this.canonical,
  );

  final String fingerprint;
  final bool canonical;
}

class _OwnedLine {
  const _OwnedLine(this.number, this.text, this.source);

  final int number;
  final String text;
  final String source;
}

class _PatchRegion {
  const _PatchRegion(this.path, this.lines);

  final String path;
  final List<_OwnedLine> lines;

  String get source => lines.map((line) => line.source).join('\n');
}

class _GlassRef {
  const _GlassRef({
    required this.name,
    required this.ref,
    required this.frozenTip,
  });

  final String name;
  final String ref;
  final String frozenTip;
}

class _CurrentLine {
  const _CurrentLine(this.number, this.text);

  final int number;
  final String text;
}
