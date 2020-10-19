## Introduction

Use his plugin to request permissions for the android part of your [Flutter](http://www.flutter.dev).

The android permission ["android.permission.SYSTEM_ALERT_WINDOW"](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW) always gets requested
at last.

## Setup

#### Android

Add the permissions your app needs to the **android/app/src/main/AndroidManifest.xml**.
Put the permissions in the **<manifest>** tag **not** into the **<application>** tag.

```dart
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.CALL_PHONE"/>
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
 <application
```

#### IOS

Currently this plugin only supports Android, if you want to you can
contribute to it.

## Usage

After adding the permissions, you can request them in your Flutter app in the following way:

#### Obtain an instance

```dart
RequestPermission requestPermission = RequestPermission.instance;
```

#### Request the permissions

```dart
RaisedButton(
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
RaisedButton(
    child: Text("request camera permission"),
    onPressed: () {
        // 27 is the requestCode
        requestPermission.requestAndroidPermission("android.permission.CAMERA", 27);
    },
),
RaisedButton(
    child: Text("request call_phone permission"),
    onPressed: () {
        // 28 is the requestCode
        requestPermission.requestAndroidPermission("android.permission.CALL_PHONE", 28);
    },
),
```

#### Listen to the user choice

```dart
requestPermission.results.listen((event) {
   event.grantedPermissions.forEach((key, value) {
      if (value) {
        print("The permission <$value> has been granted!");
      } else {
        print("The permission <$value> has NOT been granted!");
      }
    });
});
```
