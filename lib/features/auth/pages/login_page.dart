import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/server_url_security.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _serverFormKey = GlobalKey<FormState>();
  final _authFormKey = GlobalKey<FormState>();
  final _serverUrlController = TextEditingController();
  final _libraryNameController = TextEditingController();
  final _addressLabelController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiKeyController = TextEditingController();

  int _currentStep = 0;
  ServerCapabilities? _serverCapabilities;
  bool _isDetecting = false;
  String? _confirmedInsecureHttpUrl;

  @override
  void dispose() {
    _serverUrlController.dispose();
    _libraryNameController.dispose();
    _addressLabelController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _detectServer() async {
    if (!(_serverFormKey.currentState?.validate() ?? false)) return;
    if (!await _confirmInsecureHttpIfNeeded()) return;

    setState(() => _isDetecting = true);
    try {
      final repository = ref.read(authRepositoryProvider);
      final capabilities = await repository.detectServerCapabilities(
        _serverUrlController.text.trim(),
      );
      if (!mounted) return;
      setState(() {
        _serverCapabilities = capabilities;
        _isDetecting = false;
        _currentStep = 1;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isDetecting = false);
      _showError('无法连接到服务器，请检查地址是否正确');
    }
  }

  Future<void> _login() async {
    if (!(_authFormKey.currentState?.validate() ?? false)) return;
    if (!await _confirmInsecureHttpIfNeeded()) return;

    final authNotifier = ref.read(authStateProvider.notifier);
    final serverUrl = _serverUrlController.text.trim();
    final username = _usernameController.text.trim();
    final libraryName = _libraryNameController.text.trim();
    final addressLabel = _addressLabelController.text.trim();

    final success =
        _serverCapabilities?.supportsApiKey == true &&
            _apiKeyController.text.isNotEmpty
        ? await authNotifier.loginWithApiKey(
            serverUrl: serverUrl,
            username: username,
            apiKey: _apiKeyController.text.trim(),
            libraryName: libraryName,
            addressLabel: addressLabel,
          )
        : await authNotifier.loginWithPassword(
            serverUrl: serverUrl,
            username: username,
            password: _passwordController.text,
            libraryName: libraryName,
            addressLabel: addressLabel,
          );

    if (success && mounted) context.go('/home');
  }

  Future<bool> _confirmInsecureHttpIfNeeded() async {
    final serverUrl = _serverUrlController.text.trim();
    if (!isInsecureHttpUrl(serverUrl)) return true;
    if (_confirmedInsecureHttpUrl == serverUrl) return true;

    final confirmed = await showEchoBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: 'HTTP 连接不安全',
        subtitle: serverUrl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'HTTP 不会加密传输。密码、API Key、令牌以及媒体请求都可能被同一网络中的其他人窃听或篡改。'
              '仅当你信任当前网络和该服务器时才继续。',
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
            SizedBox(height: context.echoSpacing.lg),
            EchoButton.destructive(
              label: '仍然继续',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
            SizedBox(height: context.echoSpacing.xs),
            EchoButton.ghost(
              label: '取消',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(false),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) _confirmedInsecureHttpUrl = serverUrl;
    return confirmed == true;
  }

  void _showError(String message) {
    if (!mounted) return;
    showEchoMessage(context, message, kind: EchoMessageKind.error);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final busy = authState.isLoading || _isDetecting;

    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.errorMessage == null) return;
      _showError(next.errorMessage!);
      ref.read(authStateProvider.notifier).clearError();
    });

    return EchoScaffold(
      topBar: EchoTopBar(
        title: '连接到服务器',
        subtitle: _currentStep == 0 ? '先确认服务器地址' : '输入认证信息',
        leading: context.canPop()
            ? EchoIconButton(
                icon: AppIcons.back,
                label: '返回',
                onPressed: context.pop,
              )
            : null,
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                context.echoPageHorizontalPadding,
                context.echoSpacing.sm,
                context.echoPageHorizontalPadding,
                MediaQuery.viewInsetsOf(context).bottom +
                    context.echoSpacing.xxl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _LoginStepIndicator(currentStep: _currentStep),
                      SizedBox(height: context.echoSpacing.xl),
                      if (_currentStep == 0)
                        _buildServerStep()
                      else
                        _buildAuthenticationStep(),
                      SizedBox(height: context.echoSpacing.lg),
                      EchoButton.primary(
                        label: _isDetecting
                            ? '正在检测…'
                            : authState.isLoading
                            ? '正在登录…'
                            : _currentStep == 0
                            ? '下一步'
                            : '登录',
                        leadingIcon: _currentStep == 0
                            ? AppIcons.route
                            : AppIcons.key,
                        expand: true,
                        onPressed: busy
                            ? null
                            : _currentStep == 0
                            ? _detectServer
                            : _login,
                      ),
                      if (_currentStep > 0) ...<Widget>[
                        SizedBox(height: context.echoSpacing.xs),
                        EchoButton.ghost(
                          label: '上一步',
                          leadingIcon: AppIcons.back,
                          expand: true,
                          onPressed: busy
                              ? null
                              : () => setState(() => _currentStep = 0),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildServerStep() {
    return Form(
      key: _serverFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const EchoSectionHeader(
            title: '服务器',
            description: 'Echo 会先探测服务器能力，再决定可用的认证方式。',
          ),
          SizedBox(height: context.echoSpacing.md),
          EchoTextField(
            controller: _serverUrlController,
            label: '服务器地址',
            hintText: 'https://your-server.com',
            helperText: '优先使用 HTTPS。只有在可信局域网中才建议使用 HTTP。',
            leadingIcon: AppIcons.router,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '请输入服务器地址';
              }
              if (!isSupportedServerUrl(value)) {
                return '请输入完整的 URL（包括 http:// 或 https://）';
              }
              return null;
            },
          ),
          SizedBox(height: context.echoSpacing.md),
          EchoTextField(
            controller: _libraryNameController,
            label: '音乐库名称（可选）',
            hintText: '例如：家庭 NAS',
            helperText: '不填写则自动使用服务器类型。',
            leadingIcon: AppIcons.library,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: context.echoSpacing.md),
          EchoTextField(
            controller: _addressLabelController,
            label: '线路名称（可选）',
            hintText: '例如：主线路 / 家里',
            helperText: '不填写则默认使用 Primary。',
            leadingIcon: AppIcons.route,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _detectServer(),
          ),
          if (_isDetecting) ...<Widget>[
            SizedBox(height: context.echoSpacing.md),
            const _LoginBusyStatus(label: '正在检测服务器能力', icon: AppIcons.route),
          ],
        ],
      ),
    );
  }

  Widget _buildAuthenticationStep() {
    final capabilities = _serverCapabilities;
    final supportsApiKey = capabilities?.supportsApiKey == true;

    return Form(
      key: _authFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const EchoSectionHeader(
            title: '认证信息',
            description: '认证信息只用于连接你的音乐服务器。',
          ),
          if (capabilities?.isOpenSubsonic == true) ...<Widget>[
            SizedBox(height: context.echoSpacing.md),
            EchoSurface(
              level: EchoSurfaceLevel.raised,
              borderColor: context.echoColors.controlBoundary,
              padding: EdgeInsets.all(context.echoSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox.square(
                    dimension: context.echoInteraction.minimumTouchTarget,
                    child: Center(
                      child: Icon(
                        AppIcons.checkCircle,
                        color: context.echoColors.accent,
                      ),
                    ),
                  ),
                  SizedBox(width: context.echoSpacing.xs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '已检测到 OpenSubsonic',
                          style: context.echoTypography.title,
                        ),
                        SizedBox(height: context.echoSpacing.xxs),
                        Text(
                          capabilities?.serverType ?? '未知服务器类型',
                          style: context.echoTypography.body.copyWith(
                            color: context.echoColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: context.echoSpacing.md),
          EchoTextField(
            controller: _usernameController,
            label: '用户名',
            leadingIcon: AppIcons.profile,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return '请输入用户名';
              return null;
            },
          ),
          if (supportsApiKey) ...<Widget>[
            SizedBox(height: context.echoSpacing.md),
            EchoTextField(
              controller: _apiKeyController,
              label: 'API Key（推荐）',
              helperText: '填写 API Key 后将优先使用 API Key 认证。',
              leadingIcon: AppIcons.key,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.echoSpacing.md),
              child: Row(
                children: <Widget>[
                  const Expanded(child: EchoDivider()),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.echoSpacing.sm,
                    ),
                    child: Text(
                      '或使用密码',
                      style: context.echoTypography.metadata.copyWith(
                        color: context.echoColors.muted,
                      ),
                    ),
                  ),
                  const Expanded(child: EchoDivider()),
                ],
              ),
            ),
          ] else
            SizedBox(height: context.echoSpacing.md),
          EchoTextField(
            controller: _passwordController,
            label: '密码',
            leadingIcon: AppIcons.shield,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _login(),
            validator: (value) {
              if (supportsApiKey && _apiKeyController.text.isNotEmpty) {
                return null;
              }
              if (value == null || value.isEmpty) return '请输入密码';
              return null;
            },
          ),
          if (ref.watch(authStateProvider).isLoading) ...<Widget>[
            SizedBox(height: context.echoSpacing.md),
            const _LoginBusyStatus(label: '正在验证认证信息', icon: AppIcons.key),
          ],
        ],
      ),
    );
  }
}

class _LoginStepIndicator extends StatelessWidget {
  const _LoginStepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '登录进度，第 ${currentStep + 1} 步，共 2 步',
      child: ExcludeSemantics(
        child: Row(
          children: <Widget>[
            Expanded(
              child: _LoginStep(
                number: 1,
                label: '服务器',
                active: currentStep == 0,
                complete: currentStep > 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.echoSpacing.xs),
              child: SizedBox(
                width: 32,
                child: EchoDivider(
                  color: currentStep > 0
                      ? context.echoColors.accent
                      : context.echoColors.divider,
                ),
              ),
            ),
            Expanded(
              child: _LoginStep(
                number: 2,
                label: '认证',
                active: currentStep == 1,
                complete: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginStep extends StatelessWidget {
  const _LoginStep({
    required this.number,
    required this.label,
    required this.active,
    required this.complete,
  });

  final int number;
  final String label;
  final bool active;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final highlighted = active || complete;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: highlighted
                ? colors.accent.withValues(alpha: 0.14)
                : colors.raised,
            borderRadius: context.echoRadii.pill,
            border: Border.all(
              color: highlighted ? colors.accent : colors.controlBoundary,
            ),
          ),
          child: SizedBox.square(
            dimension: 36,
            child: Center(
              child: complete
                  ? Icon(AppIcons.check, size: 18, color: colors.accent)
                  : Text(
                      '$number',
                      style: context.echoTypography.label.copyWith(
                        color: highlighted ? colors.accent : colors.muted,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(width: context.echoSpacing.xs),
        Flexible(
          child: Text(
            label,
            style: context.echoTypography.label.copyWith(
              color: highlighted ? colors.ink : colors.muted,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginBusyStatus extends StatelessWidget {
  const _LoginBusyStatus({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: label,
      child: ExcludeSemantics(
        child: Row(
          children: <Widget>[
            SizedBox.square(
              dimension: context.echoInteraction.minimumTouchTarget,
              child: Center(
                child: Icon(icon, size: 20, color: context.echoColors.accent),
              ),
            ),
            SizedBox(width: context.echoSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(label, style: context.echoTypography.body),
                  SizedBox(height: context.echoSpacing.xs),
                  const EchoSkeleton.line(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
