import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../../data/models/song.dart';
import '../../../data/sources/remote/embed_service_client.dart';
import '../../../providers/music_provider.dart';
import '../../../providers/offline_download_provider.dart';
import '../../../providers/player_provider.dart';

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

  bool _isLoading = true;
  bool _isSubmitting = false;
  String? _errorText;
  MetadataCandidatesResponse? _response;
  MetadataCandidatesJobStatus? _candidateLookupStatus;
  int? _selectedCandidateIndex;
  MetadataApplyJobStatus? _jobStatus;

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

    Logger.infoWithTag(
      _logTag,
      'open editor ${_songSnapshot(widget.song, source: 'page_song')}',
    );

    Future<void>.microtask(_loadCandidates);
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
    super.dispose();
  }

  Future<void> _loadCandidates() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
      _response = null;
      _candidateLookupStatus = null;
      _jobStatus = null;
      _selectedCandidateIndex = null;
    });

    final config = ref.read(activeEmbedServiceConfigProvider);
    if (!config.isConfigured) {
      setState(() {
        _isLoading = false;
        _errorText = '当前音乐库未配置 Embed Service';
      });
      return;
    }
    if ((widget.song.path ?? '').trim().isEmpty) {
      setState(() {
        _isLoading = false;
        _errorText = '当前歌曲缺少文件路径，无法修改元数据';
      });
      return;
    }

    try {
      await _logLatestSongSnapshot();

      final client = ref.read(embedServiceClientProvider);
      Logger.infoWithTag(
        _logTag,
        'create candidates job ${_songSnapshot(widget.song, source: 'request_song')}',
      );
      final jobId = await client.createMetadataCandidatesJob(
        config: config,
        song: widget.song,
      );
      Logger.infoWithTag(
        _logTag,
        'candidates job created songId=${widget.song.id} jobId=$jobId',
      );

      MetadataCandidatesJobStatus? lastStatus;
      String? lastStatusValue;
      for (var attempt = 0; attempt < 90; attempt++) {
        final status = await client.getMetadataCandidatesJobStatus(
          config: config,
          jobId: jobId,
        );
        if (!mounted) return;
        if (status.status != lastStatusValue) {
          Logger.infoWithTag(
            _logTag,
            'candidates job status songId=${widget.song.id} jobId=$jobId status=${status.status}',
          );
          lastStatusValue = status.status;
        }
        setState(() {
          _candidateLookupStatus = status;
        });
        lastStatus = status;
        if (status.isDone || status.isFailed) break;
        await Future<void>.delayed(const Duration(seconds: 1));
      }

      if (!mounted) return;
      if (lastStatus == null) {
        setState(() {
          _isLoading = false;
          _errorText = '候选元数据任务状态查询失败';
        });
        return;
      }
      if (lastStatus.isFailed) {
        final errorText = lastStatus.error ?? '候选元数据获取失败';
        setState(() {
          _isLoading = false;
          _errorText = errorText;
        });
        return;
      }
      final response = lastStatus.result;
      if (!lastStatus.isDone || response == null) {
        setState(() {
          _isLoading = false;
          _errorText = '候选元数据仍在处理中，请稍后重试';
        });
        return;
      }
      Logger.infoWithTag(
        _logTag,
        'candidates loaded songId=${widget.song.id} count=${response.candidates.length} currentTitle="${response.current.title}" currentArtist="${response.current.artist}"',
      );
      if (!mounted) return;

      setState(() {
        _response = response;
        _isLoading = false;
      });

      // 打开页面时始终先显示歌曲当前值，不自动覆盖为第一个候选。
      _applyMetadataToForm(response.current);
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'load candidates failed ${_songSnapshot(widget.song, source: 'request_song')}',
        e,
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorText = '$e';
      });
    }
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
      _showSnackBar('该候选没有可应用的字段');
      return;
    }

    final preselectedFields = options
        .where((option) => option.changed)
        .map((option) => option.key)
        .toSet();
    if (preselectedFields.isEmpty) {
      preselectedFields.addAll(options.map((option) => option.key));
    }

    final selectedFields = await showDialog<Set<_MetadataFieldKey>>(
      context: context,
      builder: (dialogContext) => _CandidateFieldSelectionDialog(
        candidate: candidate,
        options: options,
        initialSelection: preselectedFields,
      ),
    );

    if (!mounted || selectedFields == null || selectedFields.isEmpty) {
      return;
    }

    setState(() {
      _selectedCandidateIndex = index;
    });
    _applyCandidateFields(candidate.metadata, selectedFields);

    Logger.infoWithTag(
      _logTag,
      'candidate fields applied songId=${widget.song.id} source=${candidate.source} fields=${selectedFields.map((field) => field.name).join(",")}',
    );
    _showSnackBar('已应用 ${selectedFields.length} 个字段');
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

    setState(() {});
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
    if (!_formKey.currentState!.validate()) return;

    final config = ref.read(activeEmbedServiceConfigProvider);
    if (!config.isConfigured) {
      _showSnackBar('当前音乐库未配置 Embed Service');
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
        _showSnackBar('任务状态查询失败');
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      if (lastStatus.isFailed) {
        _showSnackBar(lastStatus.error ?? '元数据修改失败');
        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      if (!lastStatus.isDone) {
        _showSnackBar('任务仍在处理中，请稍后查看');
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
      _showSnackBar(lastStatus.message ?? '元数据已更新');
      Navigator.of(context).pop(true);
    } catch (e) {
      Logger.warnWithTag(
        _logTag,
        'submit apply failed ${_songSnapshot(widget.song, source: 'request_song')}',
        e,
      );
      if (!mounted) return;
      _showSnackBar('提交失败: $e');
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

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改元数据'),
        actions: [
          IconButton(
            tooltip: '重新获取候选',
            onPressed: _isLoading || _isSubmitting ? null : _loadCandidates,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(context),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton.icon(
            onPressed: _isLoading || _isSubmitting ? null : _submit,
            icon: _isSubmitting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(
              _isSubmitting
                  ? (_jobStatus == null
                        ? '提交中...'
                        : '处理中：${_jobStatus!.statusDisplayName}')
                  : '应用到文件',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      final status = _candidateLookupStatus;
      final statusText = status?.statusDisplayName;
      final statusMessage = status?.message?.trim() ?? '';
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (statusText != null && statusText.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(statusText, textAlign: TextAlign.center),
              ],
              if (statusMessage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  statusMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (_errorText != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_errorText!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _loadCandidates,
                icon: const Icon(Icons.refresh),
                label: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }

    final response = _response;
    if (response == null) {
      return const Center(child: Text('暂无可用数据'));
    }

    final selectedCandidate = _selectedCandidateIndex != null
        ? response.candidates[_selectedCandidateIndex!]
        : null;
    final coverUrl = _coverUrlController.text.trim();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MetadataSummaryCard(title: '当前文件元数据', metadata: response.current),
            const SizedBox(height: 16),
            Text('候选方案', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '点击候选方案后，可按字段勾选要应用到表单的内容。',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            if (response.candidates.isEmpty)
              Text(
                '未找到可用候选，可直接编辑当前元数据。',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            else
              Card(
                child: Column(
                  children: [
                    for (var i = 0; i < response.candidates.length; i++)
                      Column(
                        children: [
                          ListTile(
                            enabled: !_isSubmitting,
                            selected: _selectedCandidateIndex == i,
                            title: Text(
                              response.candidates[i].metadata.title.isEmpty
                                  ? '未命名候选'
                                  : response.candidates[i].metadata.title,
                            ),
                            subtitle: Text(
                              '${response.candidates[i].source} · 置信度 ${(response.candidates[i].confidence * 100).toStringAsFixed(0)}%',
                            ),
                            trailing: const Icon(Icons.tune),
                            onTap: () => _showCandidateFieldSelector(i),
                          ),
                          if (i != response.candidates.length - 1)
                            const Divider(height: 1),
                        ],
                      ),
                  ],
                ),
              ),
            if (selectedCandidate != null) ...[
              const SizedBox(height: 16),
              _MetadataSummaryCard(
                title: '最近应用的候选',
                metadata: selectedCandidate.metadata,
              ),
            ],
            const SizedBox(height: 16),
            Text('最终提交内容', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (coverUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                ),
              ),
            _buildTextField(
              controller: _titleController,
              label: '标题',
              validator: (value) =>
                  value == null || value.trim().isEmpty ? '请输入标题' : null,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _artistController,
              label: '歌手',
              validator: (value) =>
                  value == null || value.trim().isEmpty ? '请输入歌手' : null,
            ),
            const SizedBox(height: 12),
            _buildTextField(controller: _albumController, label: '专辑'),
            const SizedBox(height: 12),
            _buildTextField(controller: _albumArtistController, label: '专辑歌手'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _trackNumberController,
                    label: '曲号',
                    keyboardType: TextInputType.number,
                    validator: _optionalNumberValidator,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _discNumberController,
                    label: '碟号',
                    keyboardType: TextInputType.number,
                    validator: _optionalNumberValidator,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _yearController,
                    label: '年份',
                    keyboardType: TextInputType.number,
                    validator: _optionalNumberValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField(controller: _genreController, label: '流派'),
            const SizedBox(height: 12),
            _buildTextField(controller: _coverUrlController, label: '封面 URL'),
            const SizedBox(height: 12),
            _buildTextField(controller: _composerController, label: '作曲'),
            const SizedBox(height: 12),
            _buildTextField(controller: _labelController, label: '厂牌'),
            const SizedBox(height: 12),
            _buildTextField(controller: _commentController, label: '备注'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _lyricsController,
              label: '歌词',
              maxLines: 8,
            ),
            if (_jobStatus != null) ...[
              const SizedBox(height: 16),
              Text(
                '任务状态：${_jobStatus!.statusDisplayName}'
                '${(_jobStatus!.message ?? '').trim().isEmpty ? '' : ' · ${_jobStatus!.message}'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      minLines: maxLines > 1 ? maxLines : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
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

class _CandidateFieldSelectionDialog extends StatefulWidget {
  final MetadataCandidate candidate;
  final List<_MetadataFieldOption> options;
  final Set<_MetadataFieldKey> initialSelection;

  const _CandidateFieldSelectionDialog({
    required this.candidate,
    required this.options,
    required this.initialSelection,
  });

  @override
  State<_CandidateFieldSelectionDialog> createState() =>
      _CandidateFieldSelectionDialogState();
}

class _CandidateFieldSelectionDialogState
    extends State<_CandidateFieldSelectionDialog> {
  late final Set<_MetadataFieldKey> _selectedFields;

  @override
  void initState() {
    super.initState();
    _selectedFields = {...widget.initialSelection};
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.options;

    return AlertDialog(
      title: Text(
        widget.candidate.metadata.title.isEmpty
            ? '候选字段选择'
            : widget.candidate.metadata.title,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.65,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.candidate.source} · 置信度 ${(widget.candidate.confidence * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedFields.addAll(
                            options.map((option) => option.key),
                          );
                        });
                      },
                      child: const Text('全选'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedFields.clear();
                        });
                      },
                      child: const Text('清空'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                for (final option in options)
                  Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          if (_selectedFields.contains(option.key)) {
                            _selectedFields.remove(option.key);
                          } else {
                            _selectedFields.add(option.key);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _selectedFields.contains(option.key),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked ?? false) {
                                    _selectedFields.add(option.key);
                                  } else {
                                    _selectedFields.remove(option.key);
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      option.label,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    option.changed
                                        ? '当前：${_displayValue(option.currentValue)}'
                                        : '当前：与候选一致',
                                    maxLines: _previewMaxLines(option.key),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '候选：${_displayValue(option.candidateValue)}',
                                    maxLines: _previewMaxLines(option.key),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _selectedFields.isEmpty
              ? null
              : () => Navigator.of(
                  context,
                ).pop(Set<_MetadataFieldKey>.from(_selectedFields)),
          child: const Text('应用所选字段'),
        ),
      ],
    );
  }
}

class _MetadataSummaryCard extends StatelessWidget {
  final String title;
  final EditableSongMetadata metadata;

  const _MetadataSummaryCard({required this.title, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final rows = <String>[
      if (metadata.title.isNotEmpty) '标题：${metadata.title}',
      if (metadata.artist.isNotEmpty) '歌手：${metadata.artist}',
      if (metadata.album.isNotEmpty) '专辑：${metadata.album}',
      if (metadata.albumArtist.isNotEmpty) '专辑歌手：${metadata.albumArtist}',
      if (metadata.trackNumber > 0) '曲号：${metadata.trackNumber}',
      if (metadata.discNumber > 0) '碟号：${metadata.discNumber}',
      if (metadata.year > 0) '年份：${metadata.year}',
      if (metadata.genre.isNotEmpty) '流派：${metadata.genre}',
      if (metadata.coverUrl.isNotEmpty) '封面：已提供',
      if (metadata.lyrics.isNotEmpty) '歌词：已提供',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            if (rows.isEmpty)
              Text(
                '暂无元数据',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            else
              for (final row in rows)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(row),
                ),
          ],
        ),
      ),
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

int _previewMaxLines(_MetadataFieldKey field) {
  return switch (field) {
    _MetadataFieldKey.lyrics => 8,
    _MetadataFieldKey.comment => 6,
    _MetadataFieldKey.coverUrl => 4,
    _ => 3,
  };
}

String _displayValue(String value) => value.trim().isEmpty ? '空' : value.trim();
