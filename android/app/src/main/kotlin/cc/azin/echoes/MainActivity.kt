package cc.azin.echoes

import android.content.Intent
import com.ryanheise.audioservice.AudioServiceFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceFragmentActivity() {
    companion object {
        private const val APP_LIFECYCLE_CHANNEL = "cc.azin.echoes/app_lifecycle"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            APP_LIFECYCLE_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "moveTaskToBack" -> {
                    try {
                        val moved = moveTaskToBack(true)
                        if (!moved) {
                            val homeIntent = Intent(Intent.ACTION_MAIN).apply {
                                addCategory(Intent.CATEGORY_HOME)
                                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                            }
                            startActivity(homeIntent)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("MOVE_TO_BACKGROUND_FAILED", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
