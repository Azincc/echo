import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/logger.dart';
import '../../../data/models/song.dart';
import '../../../data/sources/remote/embed_service_client.dart';
import '../../../providers/gd_music_provider.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../providers/player_provider.dart';

const List<String> _metadataSearchSources = <String>['netease', 'kuwo'];
const int _metadataResultsPerSource = 3;

class SongMetadataEditPage extends ConsumerStatefulWidget {
  final Song song;

  const SongMetadataEditPage({super.key, required this.song});

  @override
  ConsumerState<SongMetadataEditPage> createState() =>
      _SongMetadataEditPageState();
}

class _SongMetadataEditPageState extends ConsumerState<SongMetadataEditPage> {
  static const _logTag = 'METADATA_EDIT';
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _artistController;
  late final TextEditingController _albumController;
  late final TextEditingController _albumArtistController;
  late final TextEditingController _trackNumberController;
  late final TextEditingController _discNumberController;
  late final TextEditingController _yearController;
  late final TextEditingController _genreController;
  late final TextEditingController _coverUrlController;
  late final TextEditingController _commentController;
  late final TextEditingController _composerController;
  late final TextEditingController _labelController;
  late final TextEditingController _lyricsController;
  late final TextEditingController _searchTitleController;
  late final TextEditingController _searchAlbumController;
  late final TextEditingController _searchArtistController;

  bool _isLoading = false;
  bool _isSearching = false;
  bool _hasSearched = false;
  bool _isSubmitting = false;
  String? _errorText;
  String? _searchErrorText;
  MetadataCandidatesResponse? _response;
  int? _selectedCandidateIndex;
  MetadataApplyJobStatus? _jobStatus;
  EditableSongMetadata? _baselineMetadata;
  bool _isDirty = false;
  final Set<MetadataSearchDimension> _searchDimensions = {
    MetadataSearchDimension.title,
    MetadataSearchDimension.artist,
  };
  final Map<String, bool> _sourceSearching = <String, bool>{
    'netease': false,
    'kuwo': false,
  };
  final Map<String, String?> _sourceErrors = <String, String?>{
    'netease': null,
    'kuwo': null,
  };
  final Map<String, String?> _sourceWarnings = <String, String?>{
    'netease': null,
    'kuwo': null,
  };
  final Map<String, List<MetadataCandidate>> _sourceCandidates =
      <String, List<MetadataCandidate>>{
        'netease': <MetadataCandidate>[],
        'kuwo': <MetadataCandidate>[],
      };

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _artistController = TextEditingController();
    _albumController = TextEditingController();
    _albumArtistController = TextEditingController();
    _trackNumberController = TextEditingController();
    _discNumberController = TextEditingController();
    _yearController = TextEditingController();
    _genreController = TextEditingController();
    _coverUrlController = TextEditingController();
    _commentController = TextEditingController();
    _composerController = TextEditingController();
    _labelController = TextEditingController();
    _lyricsController = TextEditingController();
    _searchTitleController = TextEditingController(text: widget.song.title);
    _searchAlbumController = TextEditingController(text: widget.song.album);
    _searchArtistController = TextEditingController(text: widget.song.artist);

    Logger.infoWithTag(
      _logTag,
      'open editor ${_songSnapshot(widget.song, source: 'page_song')}',
    );
    _resetFromSong(notify: false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _albumController.dispose();
    _albumArtistController.dispose();
    _trackNumberController.dispose();
    _discNumberController.dispose();
    _yearController.dispose();
    _genreController.dispose();
    _coverUrlController.dispose();
    _commentController.dispose();
    _composerController.dispose();
    _labelController.dispose();
    _lyricsController.dispose();
    _searchTitleController.dispose();
    _searchAlbumController.dispose();
    _searchArtistController.dispose();
    super.dispose();
  }

  void _resetFromSong({bool notify = true}) {
    final current = _metadataFromSong(widget.song);
    _applyMetadataToForm(current);
    _syncSearchFields(current);
    void update() {
      _isLoading = false;
      _errorText = (widget.song.path ?? '').trim().isEmpty
          ? '当前歌曲缺少文件路径，无法写入元数据'
          : null;
      _searchErrorText = null;
      _jobStatus = null;
      _selectedCandidateIndex = null;
      _hasSearched = false;
      for (final source in _metadataSearchSources) {
        _sourceSearching[source] = false;
        _sourceErrors[source] = null;
        _sourceWarnings[source] = null;
        _sourceCandidates[source] = <MetadataCandidate>[];
      }
      _isSearching = false;
      _response = MetadataCandidatesResponse(
        current: current,
        candidates: const <MetadataCandidate>[],
      );
    }

    if (notify) {
      setState(update);
    } else {
      update();
    }
  }

  Future<void> _searchMetadata() async {
    final validationMessage = _searchValidationMessage;
    if (validationMessage != null) {
      setState(() {
        _searchErrorText = validationMessage;
      });
      return;
    }

    final currentResponse = _response;
    if (currentResponse == null) return;
    final query = _searchQueryPreview;
    setState(() {
      _isSearching = true;
      _hasSearched = true;
      _searchErrorText = null;
      _selectedCandidateIndex = null;
      for (final source in _metadataSearchSources) {
        _sourceSearching[source] = true;
        _sourceErrors[source] = null;
        _sourceWarnings[source] = null;
        _sourceCandidates[source] = <MetadataCandidate>[];
      }
      _response = MetadataCandidatesResponse(
        current: currentResponse.current,
        candidates: const <MetadataCandidate>[],
      );
    });

    Logger.infoWithTag(
      _logTag,
      'direct metadata search started songId=${widget.song.id} query="$query" dimensions=${_searchDimensions.map((dimension) => dimension.jsonValue).join(",")}',
    );
    await Future.wait(
      _metadataSearchSources.map(
        (source) => _searchMetadataSource(
          source,
          query: query,
          preserveExisting: false,
          loadingAlreadySet: true,
        ),
      ),
    );
  }

  Future<void> _searchMetadataSource(
    String source, {
    String? query,
    bool preserveExisting = true,
    bool loadingAlreadySet = false,
  }) async {
    final searchQuery = (query ?? _searchQueryPreview).trim();
    if (searchQuery.isEmpty) return;
    if (!loadingAlreadySet) {
      setState(() {
        _sourceSearching[source] = true;
        _sourceErrors[source] = null;
        _sourceWarnings[source] = null;
        _selectedCandidateIndex = null;
        _isSearching = true;
        _hasSearched = true;
      });
    }

    try {
      final client = ref.read(gdMusicApiClientProvider);
      final songs = await client.searchMetadataCandidates(
        keyword: searchQuery,
        source: source,
        limit: _metadataResultsPerSource,
      );
      if (!mounted) return;
      final candidates = songs
          .map(_candidateFromGdSong)
          .whereType<MetadataCandidate>()
          .toList(growable: false);
      final blankCoverCount = candidates
          .where((candidate) => candidate.metadata.coverUrl.trim().isEmpty)
          .length;
      setState(() {
        if (candidates.isNotEmpty || !preserveExisting) {
          _sourceCandidates[source] = candidates;
        }
        _sourceErrors[source] = candidates.isEmpty
            ? '此渠道返回了空列表，可单独刷新重试。'
            : null;
        _sourceWarnings[source] = blankCoverCount > 0
            ? '$blankCoverCount 条结果的封面为空，可刷新此渠道重新获取。'
            : null;
        _sourceSearching[source] = false;
        _syncCombinedCandidates();
      });
      Logger.infoWithTag(
        _logTag,
        'direct metadata source completed songId=${widget.song.id} source=$source query="$searchQuery" count=${candidates.length} blankCovers=$blankCoverCount',
      );
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'direct metadata source failed songId=${widget.song.id} source=$source query="$searchQuery"',
        e,
      );
      if (!mounted) return;
      setState(() {
        _sourceErrors[source] = '请求失败：$e';
        _sourceSearching[source] = false;
        _syncCombinedCandidates();
      });
    }
  }

  void _syncCombinedCandidates() {
    final current = _response?.current ?? _metadataFromSong(widget.song);
    _response = MetadataCandidatesResponse(
      current: current,
      candidates: <MetadataCandidate>[
        for (final source in _metadataSearchSources)
          ...?_sourceCandidates[source],
      ],
    );
    _isSearching = _sourceSearching.values.any((loading) => loading);
  }

  MetadataCandidate? _candidateFromGdSong(Song song) {
    final source = (song.previewSource ?? '').trim();
    final trackId = (song.previewTrackId ?? '').trim();
    if (source.isEmpty || trackId.isEmpty || song.title.trim().isEmpty) {
      return null;
    }
    final artist = (song.artist ?? '').trim();
    return MetadataCandidate(
      source: 'gdstudio_$source',
      trackId: trackId,
      confidence: 0,
      metadata: EditableSongMetadata(
        title: song.title.trim(),
        artist: artist,
        album: (song.album ?? '').trim(),
        albumArtist: artist,
        trackNumber: song.track ?? 0,
        year: song.year ?? 0,
        coverUrl: (song.previewCoverUrl ?? '').trim(),
      ),
    );
  }

  EditableSongMetadata _metadataFromSong(Song song) {
    final artist = (song.artist ?? '').trim();
    return EditableSongMetadata(
      title: song.title.trim(),
      artist: artist,
      album: (song.album ?? '').trim(),
      albumArtist: artist,
      trackNumber: song.track ?? 0,
      discNumber: song.discNumber ?? 0,
      year: song.year ?? 0,
      genre: (song.genre ?? '').trim(),
      coverUrl: (song.previewCoverUrl ?? '').trim(),
    );
  }

  void _syncSearchFields(EditableSongMetadata metadata) {
    _searchTitleController.text = metadata.title;
    _searchAlbumController.text = metadata.album;
    _searchArtistController.text = _formatSearchArtist(metadata.artist);
  }

  String get _searchQueryPreview {
    final parts = <String>[
      if (_searchDimensions.contains(MetadataSearchDimension.title))
        _searchTitleController.text.trim(),
      if (_searchDimensions.contains(MetadataSearchDimension.album))
        _searchAlbumController.text.trim(),
      if (_searchDimensions.contains(MetadataSearchDimension.artist))
        _searchArtistController.text.trim(),
    ].where((value) => value.isNotEmpty).toList();
    return parts.join(' - ');
  }

  String? get _searchValidationMessage {
    if (_searchDimensions.isEmpty) return '请至少选择一个搜索维度';
    if (_searchDimensions.contains(MetadataSearchDimension.title) &&
        _searchTitleController.text.trim().isEmpty) {
      return '请填写单曲名称，或取消该搜索维度';
    }
    if (_searchDimensions.contains(MetadataSearchDimension.album) &&
        _searchAlbumController.text.trim().isEmpty) {
      return '请填写专辑名称，或取消该搜索维度';
    }
    if (_searchDimensions.contains(MetadataSearchDimension.artist) &&
        _searchArtistController.text.trim().isEmpty) {
      return '请填写艺术家，或取消该搜索维度';
    }
    return null;
  }

  void _toggleSearchDimension(MetadataSearchDimension dimension) {
    setState(() {
      if (!_searchDimensions.remove(dimension)) {
        _searchDimensions.add(dimension);
      }
      _searchErrorText = null;
    });
  }

  void _handleSearchFieldChanged(String _) {
    setState(() {
      _searchErrorText = null;
    });
  }

  static String _formatSearchArtist(String value) {
    return value.replaceAll('\x00', ', ').replaceAll(' / ', ', ').trim();
  }

  void _applyMetadataToForm(EditableSongMetadata metadata) {
    _titleController.text = metadata.title;
    _artistController.text = metadata.artist;
    _albumController.text = metadata.album;
    _albumArtistController.text = metadata.albumArtist;
    _trackNumberController.text = _formatIntField(metadata.trackNumber);
    _discNumberController.text = _formatIntField(metadata.discNumber);
    _yearController.text = _formatIntField(metadata.year);
    _genreController.text = metadata.genre;
    _coverUrlController.text = metadata.coverUrl;
    _commentController.text = metadata.comment;
    _composerController.text = metadata.composer;
    _labelController.text = metadata.label;
    _lyricsController.text = metadata.lyrics;
    _baselineMetadata = metadata;
    _isDirty = false;
  }

  Future<void> _showCandidateFieldSelector(int index) async {
    final response = _response;
    if (response == null || index < 0 || index >= response.candidates.length) {
      return;
    }

    final candidate = response.candidates[index];
    final currentMetadata = _metadataFromForm();
    final options = _buildCandidateFieldOptions(
      currentMetadata: currentMetadata,
      candidateMetadata: candidate.metadata,
    );

    if (options.isEmpty) {
      _showMessage('该候选没有可应用的字段');
      return;
    }

    final preselectedFields = options
        .where((option) => option.changed)
        .map((option) => option.key)
        .toSet();
    if (preselectedFields.isEmpty) {
      preselectedFields.addAll(options.map((option) => option.key));
    }

    final selectedFields = await showEchoBottomSheet<Set<_MetadataFieldKey>>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _CandidateFieldSelectionSheet(
        candidate: candidate,
        options: options,
        initialSelection: preselectedFields,
      ),
    );

    if (!mounted || selectedFields == null || selectedFields.isEmpty) {
      return;
    }

    _applyCandidateFields(candidate.metadata, selectedFields);
    setState(() {
      _selectedCandidateIndex = index;
      _isDirty = _computeIsDirty();
    });

    Logger.infoWithTag(
      _logTag,
      'candidate fields applied songId=${widget.song.id} source=${candidate.source} fields=${selectedFields.map((field) => field.name).join(",")}',
    );
    _showMessage(
      '已应用 ${selectedFields.length} 个字段',
      kind: EchoMessageKind.success,
    );
  }

  List<_MetadataFieldOption> _buildCandidateFieldOptions({
    required EditableSongMetadata currentMetadata,
    required EditableSongMetadata candidateMetadata,
  }) {
    final options = <_MetadataFieldOption>[];
    for (final field in _metadataFieldOrder) {
      if (!_metadataFieldHasValue(field, candidateMetadata)) {
        continue;
      }

      final currentValue = _metadataFieldValue(field, currentMetadata);
      final candidateValue = _metadataFieldValue(field, candidateMetadata);
      options.add(
        _MetadataFieldOption(
          key: field,
          label: _metadataFieldLabel(field),
          currentValue: currentValue,
          candidateValue: candidateValue,
          changed: currentValue != candidateValue,
        ),
      );
    }
    return options;
  }

  void _applyCandidateFields(
    EditableSongMetadata metadata,
    Set<_MetadataFieldKey> selectedFields,
  ) {
    for (final field in selectedFields) {
      switch (field) {
        case _MetadataFieldKey.title:
          _titleController.text = metadata.title;
        case _MetadataFieldKey.artist:
          _artistController.text = metadata.artist;
        case _MetadataFieldKey.album:
          _albumController.text = metadata.album;
        case _MetadataFieldKey.albumArtist:
          _albumArtistController.text = metadata.albumArtist;
        case _MetadataFieldKey.trackNumber:
          _trackNumberController.text = _formatIntField(metadata.trackNumber);
        case _MetadataFieldKey.discNumber:
          _discNumberController.text = _formatIntField(metadata.discNumber);
        case _MetadataFieldKey.year:
          _yearController.text = _formatIntField(metadata.year);
        case _MetadataFieldKey.genre:
          _genreController.text = metadata.genre;
        case _MetadataFieldKey.coverUrl:
          _coverUrlController.text = metadata.coverUrl;
        case _MetadataFieldKey.composer:
          _composerController.text = metadata.composer;
        case _MetadataFieldKey.label:
          _labelController.text = metadata.label;
        case _MetadataFieldKey.comment:
          _commentController.text = metadata.comment;
        case _MetadataFieldKey.lyrics:
          _lyricsController.text = metadata.lyrics;
      }
    }
  }

  EditableSongMetadata _metadataFromForm() {
    return EditableSongMetadata(
      title: _titleController.text.trim(),
      artist: _artistController.text.trim(),
      album: _albumController.text.trim(),
      albumArtist: _albumArtistController.text.trim(),
      trackNumber: _parseInt(_trackNumberController.text),
      discNumber: _parseInt(_discNumberController.text),
      year: _parseInt(_yearController.text),
      genre: _genreController.text.trim(),
      coverUrl: _coverUrlController.text.trim(),
      comment: _commentController.text.trim(),
      composer: _composerController.text.trim(),
      label: _labelController.text.trim(),
      lyrics: _lyricsController.text.trim(),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final config = ref.read(activeEmbedServiceConfigProvider);
    if (!config.isConfigured) {
      _showMessage('当前音乐库未配置 Embed Service', kind: EchoMessageKind.error);
      return;
    }

    setState(() {
      _isSubmitting = true;
      _jobStatus = null;
    });

    try {
      await _logLatestSongSnapshot();

      final client = ref.read(embedServiceClientProvider);
      final metadata = _metadataFromForm();
      Logger.infoWithTag(
        _logTag,
        'submit apply songId=${widget.song.id} path="${_normalizeText(widget.song.path)}" title="${metadata.title}" artist="${metadata.artist}" album="${metadata.album}"',
      );
      final jobId = await client.applyMetadata(
        config: config,
        song: widget.song,
        metadata: metadata,
      );
      Logger.infoWithTag(
        _logTag,
        'apply job created songId=${widget.song.id} jobId=$jobId',
      );

      MetadataApplyJobStatus? lastStatus;
      for (var attempt = 0; attempt < 90; attempt++) {
        final status = await client.getMetadataJobStatus(
          config: config,
          jobId: jobId,
        );
        if (!mounted) return;
        setState(() {
          _jobStatus = status;
        });
        lastStatus = status;
        if (status.isDone || status.isFailed) break;
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      if (!mounted) return;
      if (lastStatus == null) {
        _showMessage('任务状态查询失败', kind: EchoMessageKind.error);
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      if (lastStatus.isFailed) {
        _showMessage(
          lastStatus.error ?? '元数据修改失败',
          kind: EchoMessageKind.error,
        );
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      if (!lastStatus.isDone) {
        _showMessage('任务仍在处理中，请稍后查看', kind: EchoMessageKind.warning);
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      await _refreshViews();
      if (!mounted) return;
      Logger.infoWithTag(
        _logTag,
        'apply done songId=${widget.song.id} jobId=$jobId status=${lastStatus.status}',
      );
      _showMessage(
        lastStatus.message ?? '元数据已更新',
        kind: EchoMessageKind.success,
      );
      setState(() {
        _baselineMetadata = metadata;
        _isDirty = false;
        _isSubmitting = false;
      });
      await WidgetsBinding.instance.endOfFrame;
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'submit apply failed ${_songSnapshot(widget.song, source: 'request_song')}',
        e,
      );
      if (!mounted) return;
      _showMessage('提交失败: $e', kind: EchoMessageKind.error);
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _refreshViews() async {
    ref.invalidate(allSongsProvider);
    ref.invalidate(randomSongsProvider);
    if (widget.song.albumId != null && widget.song.albumId!.trim().isNotEmpty) {
      ref.invalidate(albumDetailProvider(widget.song.albumId!));
    }
    if (widget.song.artistId != null &&
        widget.song.artistId!.trim().isNotEmpty) {
      ref.invalidate(artistDetailProvider(widget.song.artistId!));
    }
    await ref.read(playerProvider.notifier).refreshSongMetadata(widget.song.id);
  }

  Future<void> _logLatestSongSnapshot() async {
    final repository = ref.read(musicRepositoryProvider);
    if (repository == null) {
      Logger.warnWithTag(
        _logTag,
        'music repository unavailable when comparing song snapshot songId=${widget.song.id}',
      );
      return;
    }

    try {
      final latestSong = await repository.getSong(widget.song.id);
      if (latestSong == null) {
        Logger.warnWithTag(
          _logTag,
          'latest song lookup returned null songId=${widget.song.id}',
        );
        return;
      }

      final pagePath = _normalizeText(widget.song.path);
      final latestPath = _normalizeText(latestSong.path);
      final pageTitle = _normalizeText(widget.song.title);
      final latestTitle = _normalizeText(latestSong.title);

      if (pagePath != latestPath || pageTitle != latestTitle) {
        Logger.warnWithTag(
          _logTag,
          'song snapshot mismatch songId=${widget.song.id} '
          'pagePath="$pagePath" latestPath="$latestPath" '
          'pageTitle="$pageTitle" latestTitle="$latestTitle"',
        );
      } else {
        Logger.infoWithTag(
          _logTag,
          'song snapshot match songId=${widget.song.id} latestPath="$latestPath"',
        );
      }
    } catch (e, stackTrace) {
      Logger.warnWithTag(
        _logTag,
        'latest song lookup failed songId=${widget.song.id}',
        e,
      );
      Logger.debugWithTag(
        _logTag,
        'latest song lookup stackTrace songId=${widget.song.id}',
        null,
        stackTrace,
      );
    }
  }

  void _showMessage(
    String message, {
    EchoMessageKind kind = EchoMessageKind.info,
  }) {
    if (!mounted) return;
    showEchoMessage(context, message, kind: kind);
  }

  void _handleFieldChanged(String _) {
    final dirty = _computeIsDirty();
    if (dirty == _isDirty || !mounted) return;
    setState(() => _isDirty = dirty);
  }

  void _handleCoverFieldChanged(String _) {
    if (!mounted) return;
    setState(() => _isDirty = _computeIsDirty());
  }

  bool _computeIsDirty() {
    final baseline = _baselineMetadata;
    if (baseline == null) return false;
    final current = _metadataFromForm();
    return _metadataFieldOrder.any(
      (field) =>
          _metadataFieldValue(field, baseline) !=
          _metadataFieldValue(field, current),
    );
  }

  Future<void> _handlePop(bool didPop, bool? result) async {
    if (didPop) return;
    if (_isSubmitting) {
      _showMessage('正在写入音频文件，完成前无法退出', kind: EchoMessageKind.warning);
      return;
    }
    if (!_isDirty) return;

    final discard = await showEchoBottomSheet<bool>(
      context: context,
      builder: (sheetContext) => const _DiscardChangesSheet(),
    );
    if (discard != true || !mounted) return;

    setState(() => _isDirty = false);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) Navigator.of(context).pop(result);
  }

  void _selectCoverCandidate(_CoverCandidateOption option) {
    _coverUrlController.text = option.url;
    setState(() {
      _selectedCandidateIndex = option.candidateIndex;
      _isDirty = _computeIsDirty();
    });
    _showMessage('已选择${option.label}封面', kind: EchoMessageKind.success);
  }

  String _formatIntField(int value) => value > 0 ? '$value' : '';

  int _parseInt(String raw) => int.tryParse(raw.trim()) ?? 0;

  String? _optionalNumberValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    return int.tryParse(text) == null ? '请输入数字' : null;
  }

  static String _normalizeText(String? value) => (value ?? '').trim();

  static String _songSnapshot(Song song, {required String source}) {
    return 'source=$source songId=${song.id} '
        'title="${_normalizeText(song.title)}" '
        'artist="${_normalizeText(song.artist)}" '
        'album="${_normalizeText(song.album)}" '
        'path="${_normalizeText(song.path)}"';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: !_isDirty && !_isSubmitting,
      onPopInvokedWithResult: _handlePop,
      child: EchoScaffold(
        resizeToAvoidBottomInset: false,
        topBar: EchoTopBar.back(
          context: context,
          title: '修改元数据',
          subtitle: _isDirty ? '有未保存更改' : widget.song.title,
          actions: <Widget>[
            EchoIconButton(
              icon: AppIcons.refresh,
              label: '恢复歌曲当前值',
              onPressed: _isLoading || _isSearching || _isSubmitting || _isDirty
                  ? null
                  : _resetFromSong,
            ),
          ],
        ),
        body: _buildBody(context),
        bottomBar: _buildSaveBar(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const _MetadataLoadingView(
        status: '正在准备元数据',
        message: '正在读取当前歌曲信息',
      );
    }

    if (_errorText != null) {
      return EchoErrorState(
        title: '无法修改元数据',
        description: _errorText!,
        actionLabel: '恢复当前值',
        onAction: _resetFromSong,
      );
    }

    final response = _response;
    if (response == null) {
      return const EchoEmptyState(
        title: '暂无可用数据',
        description: '当前歌曲还没有可编辑的元数据结果。',
        icon: AppIcons.fileSearch,
      );
    }

    return _buildEditorLayout(response);
  }

  Widget _buildEditorLayout(MetadataCandidatesResponse response) {
    final selectedCandidate =
        _selectedCandidateIndex != null &&
            _selectedCandidateIndex! < response.candidates.length
        ? response.candidates[_selectedCandidateIndex!]
        : null;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final splitLayout =
        context.echoWindowClass == EchoWindowClass.expanded && textScale <= 1.3;
    final sourceColumn = _buildSourceColumn(response, selectedCandidate);
    final editorColumn = _buildMetadataForm();

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        key: const ValueKey<String>('song-metadata-editor-scroll'),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          context.echoPageHorizontalPadding,
          context.echoSpacing.sm,
          context.echoPageHorizontalPadding,
          context.echoSpacing.xxl + context.echoShellBottomObstruction,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.echoBreakpoints.maxContentWidth,
            ),
            child: Form(
              key: _formKey,
              child: FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: splitLayout
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 360, child: sourceColumn),
                          SizedBox(width: context.echoSpacing.xl),
                          Expanded(child: editorColumn),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          sourceColumn,
                          SizedBox(height: context.echoSpacing.xl),
                          const EchoDivider(),
                          SizedBox(height: context.echoSpacing.xl),
                          editorColumn,
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceColumn(
    MetadataCandidatesResponse response,
    MetadataCandidate? selectedCandidate,
  ) {
    final coverOptions = _buildCoverCandidateOptions(response);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const EchoSectionHeader(
          title: '当前歌曲元数据',
          description: '当前值来自音乐库，搜索与封面获取直接在客户端完成。',
        ),
        SizedBox(height: context.echoSpacing.md),
        _MetadataSummarySurface(metadata: response.current),
        SizedBox(height: context.echoSpacing.xl),
        const EchoDivider(),
        SizedBox(height: context.echoSpacing.xl),
        const EchoSectionHeader(
          title: '搜索元数据',
          description: '单曲名称、专辑名称和艺术家可以任意组合。',
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildSearchControls(),
        if (_isSearching ||
            _searchErrorText != null ||
            _hasSearched) ...<Widget>[
          SizedBox(height: context.echoSpacing.xl),
          const EchoDivider(),
          SizedBox(height: context.echoSpacing.xl),
          _buildSearchResults(response),
        ],
        if (coverOptions.isNotEmpty) ...<Widget>[
          SizedBox(height: context.echoSpacing.xl),
          const _EditorGroupHeader(
            title: '封面候选',
            description: '可直接选择封面，也可以在候选字段中一起应用。',
          ),
          SizedBox(height: context.echoSpacing.sm),
          Wrap(
            spacing: context.echoSpacing.sm,
            runSpacing: context.echoSpacing.sm,
            children: <Widget>[
              for (final option in coverOptions)
                _CoverCandidateTile(
                  option: option,
                  selected: _coverUrlController.text.trim() == option.url,
                  enabled: !_isSubmitting,
                  onPressed: () => _selectCoverCandidate(option),
                ),
            ],
          ),
        ],
        if (selectedCandidate != null) ...<Widget>[
          SizedBox(height: context.echoSpacing.xl),
          const _EditorGroupHeader(
            title: '最近应用的候选',
            description: '下方最终内容仍可继续手动调整。',
          ),
          SizedBox(height: context.echoSpacing.sm),
          _MetadataSummarySurface(metadata: selectedCandidate.metadata),
        ],
      ],
    );
  }

  Widget _buildSearchControls() {
    final validationMessage = _searchValidationMessage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: context.echoSpacing.xs,
          runSpacing: context.echoSpacing.xs,
          children: <Widget>[
            _SearchDimensionToggle(
              label: '单曲名称',
              icon: AppIcons.music,
              selected: _searchDimensions.contains(
                MetadataSearchDimension.title,
              ),
              enabled: !_isSearching && !_isSubmitting,
              onPressed: () =>
                  _toggleSearchDimension(MetadataSearchDimension.title),
            ),
            _SearchDimensionToggle(
              label: '专辑名称',
              icon: AppIcons.albumOutline,
              selected: _searchDimensions.contains(
                MetadataSearchDimension.album,
              ),
              enabled: !_isSearching && !_isSubmitting,
              onPressed: () =>
                  _toggleSearchDimension(MetadataSearchDimension.album),
            ),
            _SearchDimensionToggle(
              label: '艺术家',
              icon: AppIcons.people,
              selected: _searchDimensions.contains(
                MetadataSearchDimension.artist,
              ),
              enabled: !_isSearching && !_isSubmitting,
              onPressed: () =>
                  _toggleSearchDimension(MetadataSearchDimension.artist),
            ),
          ],
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildSearchTextField(
          controller: _searchTitleController,
          label: '单曲名称',
          icon: AppIcons.music,
          dimension: MetadataSearchDimension.title,
        ),
        SizedBox(height: context.echoSpacing.sm),
        _buildSearchTextField(
          controller: _searchAlbumController,
          label: '专辑名称',
          icon: AppIcons.albumOutline,
          dimension: MetadataSearchDimension.album,
        ),
        SizedBox(height: context.echoSpacing.sm),
        _buildSearchTextField(
          controller: _searchArtistController,
          label: '艺术家',
          icon: AppIcons.people,
          dimension: MetadataSearchDimension.artist,
          helperText: '多个艺术家可使用逗号分隔。',
        ),
        SizedBox(height: context.echoSpacing.md),
        _SearchQueryPreview(
          query: _searchQueryPreview,
          validationMessage: validationMessage,
        ),
        SizedBox(height: context.echoSpacing.md),
        EchoButton.secondary(
          label: _isSearching ? '正在搜索' : '搜索',
          leadingIcon: _isSearching ? AppIcons.timer : AppIcons.search,
          expand: true,
          onPressed: _isSearching || _isSubmitting || validationMessage != null
              ? null
              : _searchMetadata,
        ),
      ],
    );
  }

  Widget _buildSearchTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required MetadataSearchDimension dimension,
    String? helperText,
  }) {
    final selected = _searchDimensions.contains(dimension);
    return EchoTextField(
      controller: controller,
      label: label,
      leadingIcon: icon,
      helperText: helperText,
      enabled: selected && !_isSearching && !_isSubmitting,
      textInputAction: TextInputAction.search,
      onChanged: _handleSearchFieldChanged,
      onSubmitted: (_) {
        if (_searchValidationMessage == null && !_isSearching) {
          _searchMetadata();
        }
      },
    );
  }

  Widget _buildSearchResults(MetadataCandidatesResponse response) {
    final indexedCandidates = response.candidates.indexed.toList();
    final netease = indexedCandidates
        .where((entry) => entry.$2.source.contains('netease'))
        .toList();
    final kuwo = indexedCandidates
        .where((entry) => entry.$2.source.contains('kuwo'))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const EchoSectionHeader(
          title: '搜索结果',
          description: '客户端直连两个渠道，各保留前三条有效结果并独立刷新。',
        ),
        if (_searchErrorText != null) ...<Widget>[
          SizedBox(height: context.echoSpacing.sm),
          _InlineEditorNotice(
            icon: AppIcons.warning,
            message: _searchErrorText!,
          ),
        ],
        SizedBox(height: context.echoSpacing.md),
        _buildSourceSearchResults('netease', '网易云音乐', netease),
        SizedBox(height: context.echoSpacing.lg),
        _buildSourceSearchResults('kuwo', '酷我音乐', kuwo),
      ],
    );
  }

  Widget _buildSourceSearchResults(
    String source,
    String sourceLabel,
    List<(int, MetadataCandidate)> candidates,
  ) {
    final loading = _sourceSearching[source] ?? false;
    final error = _sourceErrors[source];
    final warning = _sourceWarnings[source];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _EditorGroupHeader(
                title: sourceLabel,
                description: candidates.isEmpty
                    ? '最多显示 3 条结果，可随时单独刷新。'
                    : '已显示 ${candidates.length} 条结果，可单独刷新此渠道。',
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            EchoIconButton(
              icon: loading ? AppIcons.timer : AppIcons.refresh,
              label: '刷新$sourceLabel',
              onPressed: loading || _isSubmitting
                  ? null
                  : () => _searchMetadataSource(source),
            ),
          ],
        ),
        SizedBox(height: context.echoSpacing.sm),
        if (loading) ...<Widget>[
          _InlineEditorNotice(
            icon: AppIcons.timer,
            message: candidates.isEmpty
                ? '正在搜索歌曲并获取前三条结果的封面。'
                : '正在刷新，完成前保留上一次结果。',
          ),
          SizedBox(height: context.echoSpacing.sm),
        ],
        if (error != null) ...<Widget>[
          _InlineEditorNotice(icon: AppIcons.error, message: error),
          SizedBox(height: context.echoSpacing.sm),
        ],
        if (warning != null) ...<Widget>[
          _InlineEditorNotice(icon: AppIcons.warning, message: warning),
          SizedBox(height: context.echoSpacing.sm),
        ],
        if (candidates.isEmpty && !loading)
          const _InlineEditorNotice(
            icon: AppIcons.fileSearch,
            message: '暂无有效结果；空列表不会阻塞其他渠道，可点击刷新重试。',
          )
        else
          for (var index = 0; index < candidates.length; index++) ...<Widget>[
            _MetadataCandidateRow(
              candidate: candidates[index].$2,
              resultNumber: index + 1,
              selected: _selectedCandidateIndex == candidates[index].$1,
              availableFieldCount: _metadataFieldOrder
                  .where(
                    (field) => _metadataFieldHasValue(
                      field,
                      candidates[index].$2.metadata,
                    ),
                  )
                  .length,
              enabled: !_isSubmitting,
              onPressed: () =>
                  _showCandidateFieldSelector(candidates[index].$1),
            ),
            if (index != candidates.length - 1)
              SizedBox(height: context.echoSpacing.xs),
          ],
      ],
    );
  }

  List<_CoverCandidateOption> _buildCoverCandidateOptions(
    MetadataCandidatesResponse response,
  ) {
    final options = <_CoverCandidateOption>[];
    final seenUrls = <String>{};
    final hasCandidateCover = response.candidates.any(
      (candidate) => candidate.metadata.coverUrl.trim().isNotEmpty,
    );
    if (!hasCandidateCover) return options;

    void addOption(String rawUrl, String label, int? candidateIndex) {
      final url = rawUrl.trim();
      if (url.isEmpty || !seenUrls.add(url)) return;
      options.add(
        _CoverCandidateOption(
          url: url,
          label: label,
          candidateIndex: candidateIndex,
        ),
      );
    }

    addOption(response.current.coverUrl, '当前文件', null);
    for (var index = 0; index < response.candidates.length; index++) {
      final candidate = response.candidates[index];
      final source = candidate.source.trim();
      addOption(
        candidate.metadata.coverUrl,
        source.isEmpty ? '候选 ${index + 1}' : source,
        index,
      );
    }
    return options;
  }

  Widget _buildMetadataForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const EchoSectionHeader(
          title: '最终提交内容',
          description: '这里显示的值将写入音频文件，标题与歌手为必填项。',
        ),
        SizedBox(height: context.echoSpacing.lg),
        const _EditorGroupHeader(title: '歌曲身份', description: '确认歌曲、歌手与专辑归属。'),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _titleController,
          label: '标题',
          leadingIcon: AppIcons.music,
          textInputAction: TextInputAction.next,
          validator: (value) =>
              value == null || value.trim().isEmpty ? '请输入标题' : null,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _artistController,
          label: '歌手',
          leadingIcon: AppIcons.people,
          textInputAction: TextInputAction.next,
          validator: (value) =>
              value == null || value.trim().isEmpty ? '请输入歌手' : null,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _albumController,
          label: '专辑',
          leadingIcon: AppIcons.albumOutline,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _albumArtistController,
          label: '专辑歌手',
          leadingIcon: AppIcons.people,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: context.echoSpacing.xl),
        const EchoDivider(),
        SizedBox(height: context.echoSpacing.xl),
        const _EditorGroupHeader(title: '发行信息', description: '补充曲序、碟序、年份与流派。'),
        SizedBox(height: context.echoSpacing.md),
        _buildNumberFields(),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _genreController,
          label: '流派',
          leadingIcon: AppIcons.equalizer,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: context.echoSpacing.xl),
        const EchoDivider(),
        SizedBox(height: context.echoSpacing.xl),
        const _EditorGroupHeader(
          title: '封面',
          description: '预览最终封面，或手动输入新的图片地址。',
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildCoverEditor(),
        SizedBox(height: context.echoSpacing.xl),
        const EchoDivider(),
        SizedBox(height: context.echoSpacing.xl),
        const _EditorGroupHeader(
          title: '创作与附注',
          description: '这些字段可留空，不会影响基本歌曲信息。',
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _composerController,
          label: '作曲',
          leadingIcon: AppIcons.editNote,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _labelController,
          label: '厂牌',
          leadingIcon: AppIcons.bookmark,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _commentController,
          label: '备注',
          leadingIcon: AppIcons.fileText,
          minLines: 2,
          maxLines: 4,
          textInputAction: TextInputAction.newline,
        ),
        SizedBox(height: context.echoSpacing.md),
        _buildTextField(
          controller: _lyricsController,
          label: '歌词',
          leadingIcon: AppIcons.lyrics,
          helperText: '保留原有换行，保存后会写入音频文件。',
          minLines: 6,
          maxLines: 10,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }

  Widget _buildNumberFields() {
    final fields = <Widget>[
      _buildTextField(
        controller: _trackNumberController,
        label: '曲号',
        leadingIcon: AppIcons.queue,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        validator: _optionalNumberValidator,
      ),
      _buildTextField(
        controller: _discNumberController,
        label: '碟号',
        leadingIcon: AppIcons.albumOutline,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        validator: _optionalNumberValidator,
      ),
      _buildTextField(
        controller: _yearController,
        label: '年份',
        leadingIcon: AppIcons.time,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        validator: _optionalNumberValidator,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final stack = constraints.maxWidth < 560 || textScale > 1.3;
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              fields[0],
              SizedBox(height: context.echoSpacing.md),
              fields[1],
              SizedBox(height: context.echoSpacing.md),
              fields[2],
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: fields[0]),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(child: fields[1]),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(child: fields[2]),
          ],
        );
      },
    );
  }

  Widget _buildCoverEditor() {
    final preview = _FinalCoverPreview(url: _coverUrlController.text.trim());
    final field = _buildTextField(
      controller: _coverUrlController,
      label: '封面 URL',
      leadingIcon: AppIcons.image,
      helperText: '留空会保留服务端当前处理结果。',
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      onChanged: _handleCoverFieldChanged,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final stack = constraints.maxWidth < 560 || textScale > 1.3;
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: preview),
              SizedBox(height: context.echoSpacing.md),
              field,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            preview,
            SizedBox(width: context.echoSpacing.lg),
            Expanded(child: field),
          ],
        );
      },
    );
  }

  Widget _buildSaveBar(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final canSubmit =
        !_isLoading && !_isSearching && !_isSubmitting && _response != null;
    final statusText = _saveStatusText();
    final statusIcon = _isSearching || _isSubmitting
        ? AppIcons.timer
        : _errorText != null
        ? AppIcons.error
        : _isDirty
        ? AppIcons.editNote
        : AppIcons.checkCircleOutline;
    final statusColor = _errorText != null
        ? context.echoColors.error
        : _isSearching || _isSubmitting
        ? context.echoColors.warning
        : _isDirty
        ? context.echoColors.accent
        : context.echoColors.muted;
    final saveButton = EchoButton.primary(
      label: _isSubmitting ? '正在写入文件' : '应用到文件',
      leadingIcon: _isSubmitting ? null : AppIcons.save,
      expand: true,
      enableHaptics: true,
      onPressed: canSubmit ? _submit : null,
    );

    return AnimatedPadding(
      duration: context.echoMotion.resolve(context, context.echoMotion.state),
      curve: context.echoMotion.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: EchoSurface(
        level: EchoSurfaceLevel.surface,
        borderRadius: BorderRadius.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const EchoDivider(),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.xs,
                  context.echoPageHorizontalPadding,
                  context.echoSpacing.sm,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textScale = MediaQuery.textScalerOf(context).scale(1);
                    final stack = constraints.maxWidth < 480 || textScale > 1.3;
                    final status = _EditorSaveStatus(
                      icon: statusIcon,
                      color: statusColor,
                      text: statusText,
                    );
                    if (stack) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          status,
                          SizedBox(height: context.echoSpacing.xs),
                          saveButton,
                        ],
                      );
                    }
                    return Row(
                      children: <Widget>[
                        Expanded(child: status),
                        SizedBox(width: context.echoSpacing.md),
                        SizedBox(width: 220, child: saveButton),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _saveStatusText() {
    if (_isLoading) {
      return '正在准备当前值';
    }
    if (_isSearching) {
      return '客户端正在搜索歌曲与封面';
    }
    if (_isSubmitting) {
      final status = _jobStatus;
      if (status == null) return '正在提交元数据';
      final message = status.message?.trim() ?? '';
      return message.isEmpty
          ? '处理中：${status.statusDisplayName}'
          : '${status.statusDisplayName} · $message';
    }
    if (_errorText != null) return '当前元数据不可用，请重试';
    if (_isDirty) return '有未保存的更改';
    return '可检查字段后写入音频文件';
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData leadingIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    TextInputAction? textInputAction,
    String? helperText,
    int? minLines,
    int maxLines = 1,
  }) {
    return EchoTextField(
      controller: controller,
      label: label,
      leadingIcon: leadingIcon,
      helperText: helperText,
      enabled: !_isSubmitting,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged ?? _handleFieldChanged,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      onSubmitted: textInputAction == TextInputAction.newline
          ? null
          : (_) {
              if (textInputAction == TextInputAction.done) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).nextFocus();
              }
            },
    );
  }
}

class _SearchDimensionToggle extends StatelessWidget {
  const _SearchDimensionToggle({
    required this.label,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final foreground = selected ? colors.accent : colors.ink;
    return EchoPressable(
      semanticLabel: '$label搜索维度${selected ? '，已选择' : '，未选择'}',
      selected: selected,
      toggled: selected,
      enableHaptics: true,
      onPressed: enabled ? onPressed : null,
      minimumSize: Size(
        context.echoInteraction.minimumTouchTarget,
        context.echoInteraction.minimumTouchTarget,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.1)
              : colors.surface,
          borderRadius: context.echoRadii.control,
          border: Border.all(
            color: selected ? colors.accent : colors.controlBoundary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.sm,
            vertical: context.echoSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 18, color: foreground),
              SizedBox(width: context.echoSpacing.xs),
              Text(
                label,
                style: context.echoTypography.label.copyWith(color: foreground),
              ),
              if (selected) ...<Widget>[
                SizedBox(width: context.echoSpacing.xs),
                Icon(AppIcons.check, size: 18, color: colors.accent),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchQueryPreview extends StatelessWidget {
  const _SearchQueryPreview({
    required this.query,
    required this.validationMessage,
  });

  final String query;
  final String? validationMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final hasError = validationMessage != null;
    final color = hasError ? colors.warning : colors.accent;
    final message = hasError
        ? validationMessage!
        : '将搜索：${query.isEmpty ? '尚未生成搜索词' : query}';
    return Semantics(
      liveRegion: true,
      label: message,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: context.echoRadii.control,
          border: Border.all(color: color.withValues(alpha: 0.45)),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.echoSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                hasError ? AppIcons.warning : AppIcons.search,
                size: 20,
                color: color,
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Text(
                  message,
                  style: context.echoTypography.body.copyWith(
                    color: colors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _metadataSourceLabel(String rawSource) {
  final source = rawSource.trim().toLowerCase();
  if (source.contains('netease')) return '网易云音乐';
  if (source.contains('kuwo')) return '酷我音乐';
  return rawSource.trim().isEmpty ? '未知来源' : rawSource.trim();
}

enum _MetadataFieldKey {
  title,
  artist,
  album,
  albumArtist,
  trackNumber,
  discNumber,
  year,
  genre,
  coverUrl,
  composer,
  label,
  comment,
  lyrics,
}

const List<_MetadataFieldKey> _metadataFieldOrder = [
  _MetadataFieldKey.title,
  _MetadataFieldKey.artist,
  _MetadataFieldKey.album,
  _MetadataFieldKey.albumArtist,
  _MetadataFieldKey.trackNumber,
  _MetadataFieldKey.discNumber,
  _MetadataFieldKey.year,
  _MetadataFieldKey.genre,
  _MetadataFieldKey.coverUrl,
  _MetadataFieldKey.composer,
  _MetadataFieldKey.label,
  _MetadataFieldKey.comment,
  _MetadataFieldKey.lyrics,
];

class _MetadataFieldOption {
  final _MetadataFieldKey key;
  final String label;
  final String currentValue;
  final String candidateValue;
  final bool changed;

  const _MetadataFieldOption({
    required this.key,
    required this.label,
    required this.currentValue,
    required this.candidateValue,
    required this.changed,
  });
}

class _CandidateFieldSelectionSheet extends StatefulWidget {
  const _CandidateFieldSelectionSheet({
    required this.candidate,
    required this.options,
    required this.initialSelection,
  });

  final MetadataCandidate candidate;
  final List<_MetadataFieldOption> options;
  final Set<_MetadataFieldKey> initialSelection;

  @override
  State<_CandidateFieldSelectionSheet> createState() =>
      _CandidateFieldSelectionSheetState();
}

class _CandidateFieldSelectionSheetState
    extends State<_CandidateFieldSelectionSheet> {
  late final Set<_MetadataFieldKey> _selectedFields;

  @override
  void initState() {
    super.initState();
    _selectedFields = <_MetadataFieldKey>{...widget.initialSelection};
  }

  void _toggle(_MetadataFieldKey field) {
    setState(() {
      if (!_selectedFields.remove(field)) _selectedFields.add(field);
    });
  }

  @override
  Widget build(BuildContext context) {
    final candidate = widget.candidate;
    final source = _metadataSourceLabel(candidate.source);
    final title = candidate.metadata.title.trim().isEmpty
        ? '候选字段选择'
        : candidate.metadata.title.trim();

    return EchoBottomSheet(
      title: title,
      subtitle: candidate.trackId.isEmpty
          ? source
          : '$source · 曲目 ID ${candidate.trackId}',
      constrainToAvailableHeight: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.72,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Wrap(
              spacing: context.echoSpacing.xs,
              runSpacing: context.echoSpacing.xs,
              children: <Widget>[
                EchoButton.ghost(
                  label: '全选',
                  leadingIcon: AppIcons.selectAll,
                  onPressed: () => setState(
                    () => _selectedFields.addAll(
                      widget.options.map((option) => option.key),
                    ),
                  ),
                ),
                EchoButton.ghost(
                  label: '清空',
                  leadingIcon: AppIcons.clearAll,
                  onPressed: _selectedFields.isEmpty
                      ? null
                      : () => setState(_selectedFields.clear),
                ),
              ],
            ),
            SizedBox(height: context.echoSpacing.sm),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (
                      var index = 0;
                      index < widget.options.length;
                      index++
                    ) ...<Widget>[
                      _MetadataFieldChoiceRow(
                        option: widget.options[index],
                        selected: _selectedFields.contains(
                          widget.options[index].key,
                        ),
                        onPressed: () => _toggle(widget.options[index].key),
                      ),
                      if (index != widget.options.length - 1)
                        SizedBox(height: context.echoSpacing.xs),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: context.echoSpacing.md),
            const EchoDivider(),
            SizedBox(height: context.echoSpacing.md),
            _AdaptiveSheetActions(
              secondaryLabel: '取消',
              onSecondary: () => Navigator.of(context).pop(),
              primaryLabel: '应用 ${_selectedFields.length} 个字段',
              primaryIcon: AppIcons.check,
              onPrimary: _selectedFields.isEmpty
                  ? null
                  : () => Navigator.of(
                      context,
                    ).pop(Set<_MetadataFieldKey>.from(_selectedFields)),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetadataFieldChoiceRow extends StatelessWidget {
  const _MetadataFieldChoiceRow({
    required this.option,
    required this.selected,
    required this.onPressed,
  });

  final _MetadataFieldOption option;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final statusColor = option.changed ? colors.warning : colors.muted;
    final semanticLabel = <String>[
      option.label,
      option.changed ? '当前值与候选值不同' : '当前值与候选值一致',
      '当前值 ${_displayValue(option.currentValue)}',
      '候选值 ${_displayValue(option.candidateValue)}',
      selected ? '已选择' : '未选择',
    ].join('，');

    return EchoPressable(
      semanticLabel: semanticLabel,
      selected: selected,
      onPressed: onPressed,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.1)
              : colors.raised,
          borderRadius: context.echoRadii.control,
          border: Border.all(
            color: selected ? colors.accent : colors.controlBoundary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.echoSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(
                    selected ? AppIcons.checkCircle : AppIcons.radio,
                    size: 22,
                    color: selected ? colors.accent : colors.muted,
                  ),
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: context.echoSpacing.xs,
                      runSpacing: context.echoSpacing.xxs,
                      children: <Widget>[
                        Text(option.label, style: context.echoTypography.title),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              option.changed
                                  ? AppIcons.tune
                                  : AppIcons.checkCircleOutline,
                              size: 16,
                              color: statusColor,
                            ),
                            SizedBox(width: context.echoSpacing.xxs),
                            Text(
                              option.changed ? '有差异' : '一致',
                              style: context.echoTypography.metadata.copyWith(
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: context.echoSpacing.sm),
                    Text(
                      '当前值',
                      style: context.echoTypography.label.copyWith(
                        color: colors.muted,
                      ),
                    ),
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      _displayValue(option.currentValue),
                      style: context.echoTypography.body,
                    ),
                    SizedBox(height: context.echoSpacing.sm),
                    Text(
                      '候选值',
                      style: context.echoTypography.label.copyWith(
                        color: colors.accent,
                      ),
                    ),
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      _displayValue(option.candidateValue),
                      style: context.echoTypography.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetadataCandidateRow extends StatelessWidget {
  const _MetadataCandidateRow({
    required this.candidate,
    required this.resultNumber,
    required this.selected,
    required this.availableFieldCount,
    required this.enabled,
    required this.onPressed,
  });

  final MetadataCandidate candidate;
  final int resultNumber;
  final bool selected;
  final int availableFieldCount;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final metadata = candidate.metadata;
    final title = metadata.title.trim().isEmpty
        ? '未命名候选'
        : metadata.title.trim();
    final source = _metadataSourceLabel(candidate.source);
    final detail = <String>[
      if (metadata.artist.trim().isNotEmpty) metadata.artist.trim(),
      if (metadata.album.trim().isNotEmpty) metadata.album.trim(),
    ].join(' · ');

    return EchoPressable(
      semanticLabel:
          '$source 搜索结果 $resultNumber，$title${detail.isEmpty ? '' : '，$detail'}，$availableFieldCount 个可用字段${selected ? '，最近已应用' : ''}',
      selected: selected,
      onPressed: enabled ? onPressed : null,
      minimumSize: Size(
        double.infinity,
        context.echoInteraction.expandedSongRowHeight,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: selected
              ? colors.accent.withValues(alpha: 0.1)
              : colors.surface,
          borderRadius: context.echoRadii.control,
          border: Border.all(
            color: selected ? colors.accent : colors.controlBoundary,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(context.echoSpacing.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _NetworkCoverArt(
                url: metadata.coverUrl,
                size: context.echoInteraction.minimumTouchTarget,
                semanticLabel: '$title 的候选封面',
              ),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: context.echoTypography.title),
                    if (detail.isNotEmpty) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        detail,
                        style: context.echoTypography.body.copyWith(
                          color: colors.muted,
                        ),
                      ),
                    ],
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(
                      candidate.trackId.isEmpty
                          ? '结果 $resultNumber · $availableFieldCount 个字段'
                          : '结果 $resultNumber · ID ${candidate.trackId} · $availableFieldCount 个字段',
                      style: context.echoTypography.metadata.copyWith(
                        color: colors.muted,
                      ),
                    ),
                    if (selected) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        '最近已应用',
                        style: context.echoTypography.metadata.copyWith(
                          color: colors.accent,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: context.echoSpacing.xs),
              Icon(
                selected ? AppIcons.checkCircle : AppIcons.tune,
                size: 22,
                color: selected ? colors.accent : colors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverCandidateOption {
  const _CoverCandidateOption({
    required this.url,
    required this.label,
    required this.candidateIndex,
  });

  final String url;
  final String label;
  final int? candidateIndex;
}

class _CoverCandidateTile extends StatelessWidget {
  const _CoverCandidateTile({
    required this.option,
    required this.selected,
    required this.enabled,
    required this.onPressed,
  });

  final _CoverCandidateOption option;
  final bool selected;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final width = context.echoInteraction.minimumTouchTarget * 2.5;

    return SizedBox(
      width: width,
      child: EchoPressable(
        semanticLabel: '使用${option.label}封面${selected ? '，当前已选择' : ''}',
        selected: selected,
        onPressed: enabled ? onPressed : null,
        minimumSize: Size(width, width),
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? colors.accent.withValues(alpha: 0.1)
                : colors.raised,
            borderRadius: context.echoRadii.control,
            border: Border.all(
              color: selected ? colors.accent : colors.controlBoundary,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.echoSpacing.xxs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _NetworkCoverArt(
                      url: option.url,
                      size: width - context.echoSpacing.xs,
                      semanticLabel: '${option.label}封面候选',
                    ),
                    if (selected)
                      PositionedDirectional(
                        top: context.echoSpacing.xxs,
                        end: context.echoSpacing.xxs,
                        child: EchoSurface(
                          level: EchoSurfaceLevel.floating,
                          color: colors.accent,
                          borderRadius: context.echoRadii.pill,
                          padding: EdgeInsets.all(context.echoSpacing.xxs),
                          child: Icon(
                            AppIcons.check,
                            size: 16,
                            color: colors.onAccent,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: context.echoSpacing.xs),
                Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: context.echoTypography.label,
                ),
                if (selected)
                  Text(
                    '已选择',
                    textAlign: TextAlign.center,
                    style: context.echoTypography.metadata.copyWith(
                      color: colors.accent,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NetworkCoverArt extends StatelessWidget {
  const _NetworkCoverArt({
    required this.url,
    required this.size,
    required this.semanticLabel,
    this.showMessage = false,
  });

  final String url;
  final double size;
  final String semanticLabel;
  final bool showMessage;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = url.trim();
    Widget child;
    if (normalizedUrl.isEmpty) {
      child = _CoverFallback(
        icon: AppIcons.image,
        message: showMessage ? '暂无封面' : null,
      );
    } else if (!_isHttpUrl(normalizedUrl)) {
      child = _CoverFallback(
        icon: AppIcons.image,
        message: showMessage ? '请输入有效的 HTTP 或 HTTPS 地址' : null,
      );
    } else {
      child = Image.network(
        normalizedUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, image, loadingProgress) {
          if (loadingProgress == null) return image;
          return EchoSkeleton(
            width: size,
            height: size,
            borderRadius: context.echoRadii.surface,
          );
        },
        errorBuilder: (context, error, stackTrace) => _CoverFallback(
          icon: AppIcons.brokenImage,
          message: showMessage ? '无法加载封面' : null,
        ),
      );
    }

    return Semantics(
      image: true,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: ClipRRect(
          borderRadius: context.echoRadii.surface,
          child: SizedBox.square(dimension: size, child: child),
        ),
      ),
    );
  }

  bool _isHttpUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }
}

class _CoverFallback extends StatelessWidget {
  const _CoverFallback({required this.icon, this.message});

  final IconData icon;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      borderRadius: BorderRadius.zero,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 28, color: context.echoColors.muted),
            if (message != null) ...<Widget>[
              SizedBox(height: context.echoSpacing.xs),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.echoSpacing.xs,
                ),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: context.echoTypography.metadata.copyWith(
                    color: context.echoColors.muted,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FinalCoverPreview extends StatelessWidget {
  const _FinalCoverPreview({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final size = context.echoInteraction.minimumTouchTarget * 3.5;
    return _NetworkCoverArt(
      url: url,
      size: size,
      semanticLabel: '最终封面预览',
      showMessage: true,
    );
  }
}

class _MetadataFact {
  const _MetadataFact(this.label, this.value);

  final String label;
  final String value;
}

class _MetadataSummarySurface extends StatelessWidget {
  const _MetadataSummarySurface({required this.metadata});

  final EditableSongMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final facts = <_MetadataFact>[
      if (metadata.title.trim().isNotEmpty)
        _MetadataFact('标题', metadata.title.trim()),
      if (metadata.artist.trim().isNotEmpty)
        _MetadataFact('歌手', metadata.artist.trim()),
      if (metadata.album.trim().isNotEmpty)
        _MetadataFact('专辑', metadata.album.trim()),
      if (metadata.albumArtist.trim().isNotEmpty)
        _MetadataFact('专辑歌手', metadata.albumArtist.trim()),
      if (metadata.trackNumber > 0)
        _MetadataFact('曲号', '${metadata.trackNumber}'),
      if (metadata.discNumber > 0)
        _MetadataFact('碟号', '${metadata.discNumber}'),
      if (metadata.year > 0) _MetadataFact('年份', '${metadata.year}'),
      if (metadata.genre.trim().isNotEmpty)
        _MetadataFact('流派', metadata.genre.trim()),
      if (metadata.composer.trim().isNotEmpty)
        _MetadataFact('作曲', metadata.composer.trim()),
      if (metadata.label.trim().isNotEmpty)
        _MetadataFact('厂牌', metadata.label.trim()),
      if (metadata.comment.trim().isNotEmpty)
        _MetadataFact('备注', metadata.comment.trim()),
      if (metadata.coverUrl.trim().isNotEmpty) const _MetadataFact('封面', '已提供'),
      if (metadata.lyrics.trim().isNotEmpty) const _MetadataFact('歌词', '已提供'),
    ];

    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      borderColor: context.echoColors.controlBoundary,
      padding: EdgeInsets.all(context.echoSpacing.md),
      child: facts.isEmpty
          ? Text(
              '暂无元数据',
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (var index = 0; index < facts.length; index++) ...<Widget>[
                  _MetadataFactRow(fact: facts[index]),
                  if (index != facts.length - 1) ...<Widget>[
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoDivider(),
                    SizedBox(height: context.echoSpacing.xs),
                  ],
                ],
              ],
            ),
    );
  }
}

class _MetadataFactRow extends StatelessWidget {
  const _MetadataFactRow({required this.fact});

  final _MetadataFact fact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final stack = constraints.maxWidth < 300 || textScale > 1.3;
        final label = Text(
          fact.label,
          style: context.echoTypography.label.copyWith(
            color: context.echoColors.muted,
          ),
        );
        final value = Text(fact.value, style: context.echoTypography.body);
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label,
              SizedBox(height: context.echoSpacing.xxs),
              value,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 88, child: label),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(child: value),
          ],
        );
      },
    );
  }
}

class _EditorGroupHeader extends StatelessWidget {
  const _EditorGroupHeader({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Semantics(
          header: true,
          child: Text(title, style: context.echoTypography.title),
        ),
        SizedBox(height: context.echoSpacing.xxs),
        Text(
          description,
          style: context.echoTypography.body.copyWith(
            color: context.echoColors.muted,
          ),
        ),
      ],
    );
  }
}

class _InlineEditorNotice extends StatelessWidget {
  const _InlineEditorNotice({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return EchoSurface(
      level: EchoSurfaceLevel.raised,
      padding: EdgeInsets.all(context.echoSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox.square(
            dimension: context.echoInteraction.minimumTouchTarget,
            child: Center(
              child: Icon(icon, size: 22, color: context.echoColors.muted),
            ),
          ),
          SizedBox(width: context.echoSpacing.xs),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.echoSpacing.sm),
              child: Text(
                message,
                style: context.echoTypography.body.copyWith(
                  color: context.echoColors.muted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditorSaveStatus extends StatelessWidget {
  const _EditorSaveStatus({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ExcludeSemantics(child: Icon(icon, size: 20, color: color)),
          SizedBox(width: context.echoSpacing.xs),
          Expanded(
            child: Text(
              text,
              style: context.echoTypography.metadata.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetadataLoadingView extends StatelessWidget {
  const _MetadataLoadingView({required this.status, required this.message});

  final String status;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.echoSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Semantics(
              liveRegion: true,
              label: '$status，$message',
              child: ExcludeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Align(
                      child: EchoSkeleton.circle(
                        size: context.echoInteraction.minimumTouchTarget,
                      ),
                    ),
                    SizedBox(height: context.echoSpacing.md),
                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: context.echoTypography.title,
                    ),
                    SizedBox(height: context.echoSpacing.xs),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.echoTypography.body.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                    SizedBox(height: context.echoSpacing.xl),
                    EchoSkeleton(
                      height: 112,
                      borderRadius: context.echoRadii.surface,
                    ),
                    SizedBox(height: context.echoSpacing.sm),
                    const EchoSkeleton.line(width: 220),
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoSkeleton.line(),
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoSkeleton.line(width: 280),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiscardChangesSheet extends StatelessWidget {
  const _DiscardChangesSheet();

  @override
  Widget build(BuildContext context) {
    return EchoBottomSheet(
      title: '放弃未保存的更改？',
      subtitle: '退出后，当前表单与已应用的候选字段不会写入音频文件。',
      child: _AdaptiveSheetActions(
        secondaryLabel: '继续编辑',
        onSecondary: () => Navigator.of(context).pop(false),
        primaryLabel: '放弃并退出',
        primaryIcon: AppIcons.delete,
        primaryDestructive: true,
        onPrimary: () => Navigator.of(context).pop(true),
      ),
    );
  }
}

class _AdaptiveSheetActions extends StatelessWidget {
  const _AdaptiveSheetActions({
    required this.secondaryLabel,
    required this.onSecondary,
    required this.primaryLabel,
    required this.onPrimary,
    this.primaryIcon,
    this.primaryDestructive = false,
  });

  final String secondaryLabel;
  final VoidCallback onSecondary;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final IconData? primaryIcon;
  final bool primaryDestructive;

  @override
  Widget build(BuildContext context) {
    final secondary = EchoButton.secondary(
      label: secondaryLabel,
      expand: true,
      onPressed: onSecondary,
    );
    final primary = primaryDestructive
        ? EchoButton.destructive(
            label: primaryLabel,
            leadingIcon: primaryIcon,
            expand: true,
            onPressed: onPrimary,
          )
        : EchoButton.primary(
            label: primaryLabel,
            leadingIcon: primaryIcon,
            expand: true,
            onPressed: onPrimary,
          );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(1);
        final stack = constraints.maxWidth < 420 || textScale > 1.3;
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              secondary,
              SizedBox(height: context.echoSpacing.sm),
              primary,
            ],
          );
        }
        return Row(
          children: <Widget>[
            Expanded(child: secondary),
            SizedBox(width: context.echoSpacing.sm),
            Expanded(child: primary),
          ],
        );
      },
    );
  }
}

String _metadataFieldLabel(_MetadataFieldKey field) {
  return switch (field) {
    _MetadataFieldKey.title => '标题',
    _MetadataFieldKey.artist => '歌手',
    _MetadataFieldKey.album => '专辑',
    _MetadataFieldKey.albumArtist => '专辑歌手',
    _MetadataFieldKey.trackNumber => '曲号',
    _MetadataFieldKey.discNumber => '碟号',
    _MetadataFieldKey.year => '年份',
    _MetadataFieldKey.genre => '流派',
    _MetadataFieldKey.coverUrl => '封面 URL',
    _MetadataFieldKey.composer => '作曲',
    _MetadataFieldKey.label => '厂牌',
    _MetadataFieldKey.comment => '备注',
    _MetadataFieldKey.lyrics => '歌词',
  };
}

bool _metadataFieldHasValue(
  _MetadataFieldKey field,
  EditableSongMetadata metadata,
) {
  return switch (field) {
    _MetadataFieldKey.title => metadata.title.trim().isNotEmpty,
    _MetadataFieldKey.artist => metadata.artist.trim().isNotEmpty,
    _MetadataFieldKey.album => metadata.album.trim().isNotEmpty,
    _MetadataFieldKey.albumArtist => metadata.albumArtist.trim().isNotEmpty,
    _MetadataFieldKey.trackNumber => metadata.trackNumber > 0,
    _MetadataFieldKey.discNumber => metadata.discNumber > 0,
    _MetadataFieldKey.year => metadata.year > 0,
    _MetadataFieldKey.genre => metadata.genre.trim().isNotEmpty,
    _MetadataFieldKey.coverUrl => metadata.coverUrl.trim().isNotEmpty,
    _MetadataFieldKey.composer => metadata.composer.trim().isNotEmpty,
    _MetadataFieldKey.label => metadata.label.trim().isNotEmpty,
    _MetadataFieldKey.comment => metadata.comment.trim().isNotEmpty,
    _MetadataFieldKey.lyrics => metadata.lyrics.trim().isNotEmpty,
  };
}

String _metadataFieldValue(
  _MetadataFieldKey field,
  EditableSongMetadata metadata,
) {
  return switch (field) {
    _MetadataFieldKey.title => metadata.title.trim(),
    _MetadataFieldKey.artist => metadata.artist.trim(),
    _MetadataFieldKey.album => metadata.album.trim(),
    _MetadataFieldKey.albumArtist => metadata.albumArtist.trim(),
    _MetadataFieldKey.trackNumber =>
      metadata.trackNumber > 0 ? '${metadata.trackNumber}' : '',
    _MetadataFieldKey.discNumber =>
      metadata.discNumber > 0 ? '${metadata.discNumber}' : '',
    _MetadataFieldKey.year => metadata.year > 0 ? '${metadata.year}' : '',
    _MetadataFieldKey.genre => metadata.genre.trim(),
    _MetadataFieldKey.coverUrl => metadata.coverUrl.trim(),
    _MetadataFieldKey.composer => metadata.composer.trim(),
    _MetadataFieldKey.label => metadata.label.trim(),
    _MetadataFieldKey.comment => metadata.comment.trim(),
    _MetadataFieldKey.lyrics => metadata.lyrics.trim(),
  };
}

String _displayValue(String value) => value.trim().isEmpty ? '空' : value.trim();
