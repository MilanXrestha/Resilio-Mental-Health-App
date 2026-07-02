# Rules for eSewa SDK which is missing kotlinx.parcelize in its compiled AAR
-dontwarn kotlinx.parcelize.Parcelize
-keep class com.f1soft.esewasdk.** { *; }
-keep class kotlinx.parcelize.** { *; }
