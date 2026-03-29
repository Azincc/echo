import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// 加载签名配置
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "com.az1n.echoes"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.az1n.echoes"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        // 仅当 key.properties 存在时创建 release 签名配置
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                val keyPass = keystoreProperties.getProperty("keyPassword")
                keyPassword = if (keyPass.isNullOrEmpty()) keystoreProperties.getProperty("storePassword") else keyPass
                storeFile = if (keystoreProperties.getProperty("storeFile").startsWith("/")) {
                    file(keystoreProperties.getProperty("storeFile"))
                } else {
                    file(keystoreProperties.getProperty("storeFile"))
                }
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            // 如果有签名配置则使用，否则使用 debug 签名（适用于 CI 环境）
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            // 防止 R8 压缩掉通知图标资源
            isShrinkResources = false
            isMinifyEnabled = false
        }
    }
}

flutter {
    source = "../.."
}
