package com.example.trim_app

import io.flutter.app.FlutterApplication
import com.yandex.mapkit.MapKitFactory

class MainApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("c6ae1fc8-0061-481a-bc19-5bfdbd9de1a4")
    }
}