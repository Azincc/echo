import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    if (!_serverFormKey.currentState!.validate()) return;
    if (!await _confirmInsecureHttpIfNeeded()) return;

    setState(() {
      _isDetecting = true;
    });

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

      setState(() {
        _isDetecting = false;
      });
      _showError('无法连接到服务器，请检查地址是否正确');
    }
  }

  Future<void> _login() async {
    if (!_authFormKey.currentState!.validate()) return;
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

    if (success && mounted && context.mounted) {
      context.go('/home');
    }
  }

  Future<bool> _confirmInsecureHttpIfNeeded() async {
    final serverUrl = _serverUrlController.text.trim();
    if (!isInsecureHttpUrl(serverUrl)) {
      return true;
    }
    if (_confirmedInsecureHttpUrl == serverUrl) {
      return true;
    }

    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('HTTP 连接不安全'),
            content: Text(
              '当前服务器地址使用的是 HTTP：\n$serverUrl\n\n'
              'HTTP 不会加密传输。密码、API Key、令牌以及媒体请求都可能被同一网络中的其他人窃听或篡改。'
              '仅当你信任当前网络和该服务器时才继续。',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('继续'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      _confirmedInsecureHttpUrl = serverUrl;
    }
    return confirmed;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.errorMessage != null) {
        _showError(next.errorMessage!);
        ref.read(authStateProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('连接到服务器')),
      body: SafeArea(
        child: Stepper(
          clipBehavior: Clip.none,
          currentStep: _currentStep,
          onStepCancel: _currentStep > 0
              ? () {
                  setState(() {
                    _currentStep--;
                  });
                }
              : null,
          onStepContinue: _currentStep == 0 ? _detectServer : _login,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: (authState.isLoading || _isDetecting)
                        ? null
                        : details.onStepContinue,
                    child: Text(_currentStep == 0 ? '下一步' : '登录'),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: (authState.isLoading || _isDetecting)
                          ? null
                          : details.onStepCancel,
                      child: const Text('上一步'),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('服务器地址'),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
              content: Form(
                key: _serverFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _serverUrlController,
                      decoration: const InputDecoration(
                        labelText: '服务器地址',
                        hintText: 'https://your-server.com',
                        floatingLabelStyle: TextStyle(height: 1.2),
                        visualDensity: VisualDensity.standard,
                        contentPadding: EdgeInsets.fromLTRB(12, 22, 12, 14),
                        helperText: '优先使用 HTTPS。只有在可信局域网中才建议使用 HTTP。',
                      ),
                      keyboardType: TextInputType.url,
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _libraryNameController,
                      decoration: const InputDecoration(
                        labelText: '音乐库名称（可选）',
                        hintText: '例如：家庭 NAS',
                        helperText: '不填写则自动使用服务器类型',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressLabelController,
                      decoration: const InputDecoration(
                        labelText: '线路名称（可选）',
                        hintText: '例如：主线路 / 家里',
                        helperText: '不填写则默认使用 Primary',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    if (_isDetecting) ...[
                      const SizedBox(height: 16),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 8),
                      const Text('正在检测服务器...'),
                    ],
                  ],
                ),
              ),
            ),
            Step(
              title: const Text('认证信息'),
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
              content: Form(
                key: _authFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_serverCapabilities != null) ...[
                      if (_serverCapabilities!.isOpenSubsonic)
                        Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '检测到 OpenSubsonic 服务器: '
                                    '${_serverCapabilities!.serverType ?? "未知"}',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: '用户名'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '请输入用户名';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_serverCapabilities?.supportsApiKey == true) ...[
                      TextFormField(
                        controller: _apiKeyController,
                        decoration: const InputDecoration(
                          labelText: 'API Key（推荐）',
                          helperText: '使用 API Key 认证更加安全',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      const Text('或者使用密码：'),
                      const SizedBox(height: 8),
                    ],
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: '密码'),
                      obscureText: true,
                      validator: (value) {
                        if (_serverCapabilities?.supportsApiKey == true &&
                            _apiKeyController.text.isNotEmpty) {
                          return null;
                        }
                        if (value == null || value.isEmpty) {
                          return '请输入密码';
                        }
                        return null;
                      },
                    ),
                    if (authState.isLoading) ...[
                      const SizedBox(height: 16),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 8),
                      const Text('正在登录...'),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
