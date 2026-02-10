import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../data/repositories/auth_repository.dart';

/// 登录页面
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _serverUrlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiKeyController = TextEditingController();

  int _currentStep = 0;
  ServerCapabilities? _serverCapabilities;
  bool _isDetecting = false;

  @override
  void dispose() {
    _serverUrlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  /// 探测服务器能力
  Future<void> _detectServer() async {
    if (_serverUrlController.text.isEmpty) {
      _showError('请输入服务器地址');
      return;
    }

    setState(() {
      _isDetecting = true;
    });

    try {
      final repository = ref.read(authRepositoryProvider);
      final capabilities = await repository.detectServerCapabilities(
        _serverUrlController.text.trim(),
      );

      setState(() {
        _serverCapabilities = capabilities;
        _isDetecting = false;
        _currentStep = 1;
      });
    } catch (e) {
      setState(() {
        _isDetecting = false;
      });
      _showError('无法连接到服务器，请检查地址是否正确');
    }
  }

  /// 执行登录
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final authNotifier = ref.read(authStateProvider.notifier);
    bool success;

    if (_serverCapabilities?.supportsApiKey == true &&
        _apiKeyController.text.isNotEmpty) {
      // 使用 API Key 登录
      success = await authNotifier.loginWithApiKey(
        serverUrl: _serverUrlController.text.trim(),
        username: _usernameController.text.trim(),
        apiKey: _apiKeyController.text.trim(),
      );
    } else {
      // 使用密码登录
      success = await authNotifier.loginWithPassword(
        serverUrl: _serverUrlController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );
    }

    if (success && mounted) {
      // 登录成功，导航会由路由自动处理
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // 显示错误消息
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.errorMessage != null) {
        _showError(next.errorMessage!);
        ref.read(authStateProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('连接到服务器'),
      ),
      body: SafeArea(
        child: Stepper(
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
            // Step 1: 输入服务器地址
            Step(
              title: const Text('服务器地址'),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _serverUrlController,
                      decoration: const InputDecoration(
                        labelText: '服务器地址',
                        hintText: 'https://your-server.com',
                        helperText: '输入你的 Navidrome 服务器地址',
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入服务器地址';
                        }
                        if (!value.startsWith('http://') &&
                            !value.startsWith('https://')) {
                          return '请输入完整的 URL（包括 http:// 或 https://）';
                        }
                        return null;
                      },
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
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),

            // Step 2: 输入认证信息
            Step(
              title: const Text('认证信息'),
              content: Column(
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
                                  '检测到 OpenSubsonic 服务器: ${_serverCapabilities!.serverType ?? "未知"}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimaryContainer,
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
                    decoration: const InputDecoration(
                      labelText: '用户名',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                    decoration: const InputDecoration(
                      labelText: '密码',
                    ),
                    obscureText: true,
                    validator: (value) {
                      // 如果有 API Key，密码可以为空
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
              isActive: _currentStep >= 1,
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }
}
