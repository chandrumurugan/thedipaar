package com.example.thedipaar

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Configure Firebase with custom options
        val options = FirebaseOptions.Builder()
            .setApplicationId("1:1017496235042:android:94c62ecb8c24d36670ee7b") // Required for Analytics.
            .setProjectId("thedipaar-news") // Required for Firebase Installations.
            .setApiKey("AIzaSyCX-wxUqd4VMlJQMRYBnnbGnxWQxIl14Lw")
            .build()
        
        FirebaseApp.initializeApp(this, options, "Thedipaar news")
    }
}
