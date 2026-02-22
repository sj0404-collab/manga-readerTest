# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# signingConfig or minifyEnabled settings in build.gradle.

# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Room
-keep class * extends androidx.room.RoomDatabase
-dontwarn androidx.room.**

# Retrofit
-dontwarn okhttp3.**
-dontwarn retrofit2.**

# Serialization
-keepclassmembers class * implements com.google.protobuf.MessageLite {
  <fields>;
}

# Hilt
-keep class dagger.hilt.** { *; }
-keep class javax.inject.** { *; }
-keep interface dagger.hilt.** { *; }

# ML Kit
-keep class com.google.mlkit.** { *; }
