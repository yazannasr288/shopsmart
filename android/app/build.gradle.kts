plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.shopsmart"

    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.example.shopsmart"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Temporary debug signing for local release testing.
            // Configure a real release keystore before publishing.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    jvmToolchain(17)
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.19.0"))
}

flutter {
    source = "../.."
}