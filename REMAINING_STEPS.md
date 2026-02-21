# 完成 Embed Service 集成的剩余步骤

## 当前状态

✅ **已完成（80%）**:
- EmbedServiceClient 实现
- EmbedServiceConfig 模型
- OfflineDownloadTask 模型更新
- OfflineDownloadService 重写
- Provider 更新
- UI 页面更新（任务列表）

⚠️ **待完成（20%）**:
- 音乐库配置页面 UI
- 其他页面的调用点更新

---

## 步骤 1：更新音乐库配置页面

**文件**: `lib/features/library/pages/edit_library_page.dart`

### 1.1 修改导入

```dart
// 删除
import '../../data/models/aria2_config.dart';

// 添加
import '../../data/models/embed_service_config.dart';
```

### 1.2 修改 State 变量

```dart
// 删除
bool _aria2Enabled = false;
final _aria2RpcUrlController = TextEditingController();
final _aria2UsernameController = TextEditingController();
final _aria2PasswordController = TextEditingController();
final _aria2DownloadDirController = TextEditingController();

// 添加
bool _embedEnabled = false;
final _embedBaseUrlController = TextEditingController();
final _embedApiKeyController = TextEditingController();
final _embedLibraryIdController = TextEditingController();
```

### 1.3 修改初始化逻辑

在 `useEffect` 或类似地方，将：

```dart
final aria2Config = Aria2Config.fromLibraryExtensions(library.extensions);
_aria2Enabled = aria2Config.enabled;
_aria2RpcUrlController.text = aria2Config.rpcUrl;
_aria2UsernameController.text = aria2Config.username;
_aria2PasswordController.text = aria2Config.password;
_aria2DownloadDirController.text = aria2Config.downloadDir;
```

改为：

```dart
final embedConfig = EmbedServiceConfig.fromLibraryExtensions(library.extensions);
_embedEnabled = embedConfig.enabled;
_embedBaseUrlController.text = embedConfig.baseUrl;
_embedApiKeyController.text = embedConfig.apiKey;
_embedLibraryIdController.text = embedConfig.libraryId;
```

### 1.4 更新表单 UI

将 Aria2 配置表单改为：

```dart
ExpansionTile(
  title: const Text('Embed Service 离线下载'),
  subtitle: Text(_embedEnabled ? '已启用' : '未启用'),
  children: [
    SwitchListTile(
      title: const Text('启用 Embed Service'),
      value: _embedEnabled,
      onChanged: (v) => setState(() => _embedEnabled = v),
    ),
    Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _embedBaseUrlController,
            decoration: const InputDecoration(
              labelText: 'Embed Service URL',
              hintText: 'http://localhost:8080',
              prefixIcon: Icon(Icons.cloud),
            ),
            enabled: _embedEnabled,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _embedApiKeyController,
            decoration: const InputDecoration(
              labelText: 'API Key',
              hintText: 'your-api-key',
              prefixIcon: Icon(Icons.key),
            ),
            enabled: _embedEnabled,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _embedLibraryIdController,
            decoration: const InputDecoration(
              labelText: 'Library ID',
              hintText: 'default',
              prefixIcon: Icon(Icons.library_music),
            ),
            enabled: _embedEnabled,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _embedEnabled ? _testEmbedConnection : null,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('测试连接'),
          ),
        ],
      ),
    ),
  ],
)
```

### 1.5 更新测试连接方法

```dart
Future<void> _testEmbedConnection() async {
  if (!_embedEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('请先启用 Embed Service 配置')),
    );
    return;
  }

  final config = _currentEmbedServiceConfig();
  if (!config.isConfigured) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('请先填写 URL 和 API Key')),
    );
    return;
  }

  try {
    final service = ref.read(offlineDownloadServiceProvider);
    await service.testConnection(config);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('连接成功！')),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('连接失败: $e')),
      );
    }
  }
}
```

### 1.6 更新保存逻辑

```dart
EmbedServiceConfig _currentEmbedServiceConfig() {
  return EmbedServiceConfig(
    enabled: _embedEnabled,
    baseUrl: _embedBaseUrlController.text.trim(),
    apiKey: _embedApiKeyController.text.trim(),
    libraryId: _embedLibraryIdController.text.trim(),
  );
}

Future<void> _saveLibrary(MusicLibrary original) async {
  if (_formKey.currentState!.validate()) {
    final repo = ref.read(libraryRepositoryProvider);
    final extensions = Map<String, dynamic>.from(original.extensions);

    // 替换 aria2 为 embedService
    extensions.remove('aria2'); // 删除旧配置
    extensions['embedService'] = _currentEmbedServiceConfig().toJson();

    final updated = original.copyWith(
      name: _nameController.text,
      extensions: extensions,
      updatedAt: DateTime.now(),
    );

    await repo.update(updated);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
```

---

## 步骤 2：更新其他调用点

### 2.1 查找所有使用点

```bash
cd /Users/azin/echo
grep -r "activeAria2ConfigProvider" lib/
grep -r "aria2Client" lib/
```

### 2.2 替换导入和调用

在找到的文件中：

**替换导入**:
```dart
// 删除
import 'aria2_config.dart';
import 'aria2_rpc_client.dart';

// 添加
import 'embed_service_config.dart';
import 'embed_service_client.dart';
```

**替换 Provider**:
```dart
// 删除
final config = ref.watch(activeAria2ConfigProvider);

// 添加
final config = ref.watch(activeEmbedServiceConfigProvider);
```

**替换方法调用**:
```dart
// 旧代码
await service.enqueuePreviewSong(
  song: song,
  libraryId: library.id,
  config: aria2Config,
);

// 新代码
await service.enqueuePreviewSong(
  song: song,
  libraryId: library.id,
  config: embedConfig,
);
```

---

## 步骤 3：测试

### 3.1 启动 Embed Service

```bash
# 终端 1
cd /Users/azin/PycharmProjects/gdstudio-embeded-service
./bin/api

# 终端 2
./bin/worker
```

### 3.2 配置 Echo

1. 打开 Echo 应用
2. 进入音乐库设置
3. 启用 Embed Service
4. 填写配置:
   - URL: `http://localhost:8080`
   - API Key: `dev-api-key-please-change-in-production`
   - Library ID: `default`
5. 点击"测试连接"，确保成功

### 3.3 测试下载

1. 浏览试听歌曲（从 GDStudio）
2. 点击"加入离线队列"
3. 查看"离线下载状态"页面
4. 观察状态变化：
   - ✅ queued（等待中）
   - ✅ resolving（解析中）
   - ✅ downloading（下载中）
   - ✅ tagging（写入标签）
   - ✅ moving（移动文件）
   - ✅ scanning（扫描中）
   - ✅ completed（已完成）

### 3.4 测试失败重试

1. 提交一个无效的 track_id
2. 等待任务失败
3. 点击重试按钮
4. 观察任务重新进入队列

---

## 步骤 4：清理旧代码（可选）

完成测试后，可以删除不再使用的文件：

```bash
# 备份后删除
rm lib/data/models/aria2_config.dart
rm lib/data/sources/remote/aria2_rpc_client.dart
```

但建议先保留一段时间，确保没有遗漏的调用点。

---

## 常见问题

### Q1: 连接测试失败

**检查**:
1. Embed Service 是否启动？
2. URL 是否正确？（注意端口 8080）
3. API Key 是否正确？

**解决**:
```bash
# 测试 Embed Service
curl http://localhost:8080/healthz

# 应该返回：
{"status":"healthy","version":"1.0.0-m1",...}
```

### Q2: 任务卡在 queued 状态

**检查**:
1. Worker 是否启动？
2. Worker 日志是否有错误？

**解决**:
```bash
# 查看 Worker 日志
tail -f worker.log

# 手动刷新
curl http://localhost:8080/v1/jobs
```

### Q3: 下载失败

**检查**:
1. GDStudio API 是否可访问？
2. Track ID 是否有效？
3. Worker 日志中的错误信息

**解决**:
查看 Worker 日志，根据错误信息调试。

---

## 完成检查清单

- [ ] 修改音乐库配置页面导入
- [ ] 更新 State 变量定义
- [ ] 更新初始化逻辑
- [ ] 更新表单 UI
- [ ] 实现测试连接方法
- [ ] 更新保存逻辑
- [ ] 查找并更新其他调用点
- [ ] 测试连接成功
- [ ] 测试提交任务成功
- [ ] 测试状态流转正常
- [ ] 测试重试功能
- [ ] 测试清理功能
- [ ] 更新文档（可选）
- [ ] 清理旧代码（可选）

---

**预计完成时间**: 1-2 小时

**难度**: ⭐⭐☆☆☆（中等）

**建议**: 一步步完成，每完成一步就测试一次，确保没有遗漏。
