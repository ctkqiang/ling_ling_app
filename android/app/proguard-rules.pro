#############################################
# 🌸 灵玲反诈 ProGuard Rules (Flutter Android)
# 适配: FlutterDefend + SQLite + Logger + Huawei AGC(可选)
#############################################

# ========== Flutter Engine ==========
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# ========== 保留主入口 ==========
-keep class xin.ctkqiang.ling_ling_app.MainActivity { *; }
-keep class xin.ctkqiang.ling_ling_app.Application { *; }

# ========== Flutter 插件与 JNI ==========
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.engine.FlutterEngine { *; }
-keep class io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }

# ========== Logger ==========
# 如果你使用的是 pub.dev 的 logger 库，它是 Dart 实现，不涉及 Java 混淆
# 但是 native log utils（如 Timber/Logcat）也可以保留
-keep class android.util.Log { *; }
-keep class timber.log.Timber { *; }
-dontwarn timber.log.Timber

# ========== SQLite ==========
# SQLite 不需要混淆保护，除非你手动写了 native DAO/ORM 层
# 如果用了 `android.database.sqlite` 需要保留原始类名
-keep class android.database.** { *; }
-dontwarn android.database.**

# ========== FlutterDefend 插件 ==========
-keep class xin.ctkqiang.ling_ling_app.plugins.FlutterDefend { *; }
-keep class xin.ctkqiang.ling_ling_app.plugins.** { *; }

# ========== Gson/序列化支持 ==========
-keep class * implements java.io.Serializable { *; }
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**
-keepclassmembers class * {
   @com.google.gson.annotations.SerializedName <fields>;
}

# ========== Huawei AGC（可选） ==========
-keep class com.huawei.agconnect.** { *; }
-dontwarn com.huawei.agconnect.**

# ========== RxJava（如果用了） ==========
-dontwarn io.reactivex.**
-keep class io.reactivex.** { *; }

# ========== 保留 @Keep 标注 ==========
-keep @androidx.annotation.Keep class * {*;}
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# ========== 避免混淆你的 model（根据需要） ==========
-keep class xin.ctkqiang.ling_ling_app.models.** { *; }

# ========== 避免混淆一些反射调用 ==========
-keepclassmembers class * {
    public <init>(...);
}
