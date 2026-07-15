import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing values may come from ignored local properties or ECHO_* env vars.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

fun releaseSigningValue(propertyName: String, environmentName: String): String? {
    return System.getenv(environmentName)?.trim()?.takeIf { it.isNotEmpty() }
        ?: keystoreProperties.getProperty(propertyName)?.trim()?.takeIf { it.isNotEmpty() }
}

val configuredReleaseStoreFile = releaseSigningValue("storeFile", "ECHO_STORE_FILE")
    ?.let { project.file(it) }
val defaultReleaseStoreFile = project.file("Z:/echokey/keystore.jks")
val releaseStoreFile = configuredReleaseStoreFile
    ?.takeIf { it.isFile }
    ?: defaultReleaseStoreFile
val releaseStorePassword = releaseSigningValue("storePassword", "ECHO_STORE_PASSWORD")
val releaseKeyAlias = releaseSigningValue("keyAlias", "ECHO_KEY_ALIAS")
val releaseKeyPassword = releaseSigningValue("keyPassword", "ECHO_KEY_PASSWORD")
    ?: releaseStorePassword
val hasReleaseSigning = releaseStoreFile.isFile &&
    releaseStorePassword != null &&
    releaseKeyAlias != null &&
    releaseKeyPassword != null

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
        // Never create or apply release signing unless the full credential set exists.
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
                storeFile = releaseStoreFile
                storePassword = releaseStorePassword
            }
        }
    }

    buildTypes {
        debug {
            // Flutter debug launches always use Android's system debug keystore.
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            // Preserve unsigned-CI behavior by falling back to debug signing.
            signingConfig = if (hasReleaseSigning) {
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
