## Introduction

Use this plugin to request the declared permissions in your apps `AndroidManifest.xml`.

The android permission ["android.permission.SYSTEM_ALERT_WINDOW"](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW) always gets requested at last.

## Setup

### Android

Add the permissions your app needs to the **android/app/src/main/AndroidManifest.xml**.
Put the permissions in the **manifest** tag, infront of the **application** tag.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.project">

    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.CALL_PHONE"/>
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
 <application>
 ...
```

### IOS

Currently this plugin only supports Android, if you want to you can
contribute to it.

## Usage

After adding the permissions, you can request them in your Flutter app.

### Obtain the instance

```dart
RequestPermission requestPermission = RequestPermission.instance;
```

### Request the permissions

```dart
ElevatedButton(
    child: Text("request permissions"),
    onPressed: () {
        // 101 is the requestCode
        requestPermission.requestMultipleAndroidPermissions({
            "android.permission.CAMERA",
            "android.permission.CALL_PHONE",
            "android.permission.SYSTEM_ALERT_WINDOW"
        }, 101);
    },
),
```

Or request just one permission:

```dart
ElevatedButton(
    child: Text("request camera permission"),
    onPressed: () {
        // 27 is the requestCode
        requestPermission.requestAndroidPermission("android.permission.CAMERA", 27);
    },
),
ElevatedButton(
    child: Text("request call_phone permission"),
    onPressed: () {
        // 28 is the requestCode
        requestPermission.requestAndroidPermission("android.permission.CALL_PHONE", 28);
    },
),
```

### Listen to the users choice

```dart
requestPermission.results.listen((event) {
   event.grantedPermissions.forEach((permission, isGranted) {
      if (isGranted) {
        print("The permission \"$permission\" has been granted!");
      } else {
        print("The permission \"$permission\" has NOT been granted!");
      }
    });
});
```