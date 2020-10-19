package com.twelve_ampere.request_permission;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import java.util.ArrayList;
import java.util.Arrays;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

public class RequestPermissionPlugin implements
        FlutterPlugin,
        MethodCallHandler,
        EventChannel.StreamHandler,
        ActivityAware {

    public static final String LOG_TAG = RequestPermissionPlugin.class.getSimpleName();

    private static final String NAMESPACE = "com.twelve_ampere.request_permission.RequestPermissionPlugin";
    private static final String METHODCHANNEL_ID = NAMESPACE + ".methods";
    private static final String EVENTCHANNEL_ID = NAMESPACE + ".events";

    private MethodChannel channel;
    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;

    private final PluginRegistry.RequestPermissionsResultListener permissionsResultListener;
    private final PluginRegistry.ActivityResultListener activityResultListener;

    private ActivityPluginBinding activityBinding;
    /**
     * logLevel is initialized with 2, which stands for verbose
     * {@link android.util.Log#VERBOSE}
     */
    private int logLevel;

    public RequestPermissionPlugin() {
        logLevel = 2;
        Log.setLogLevel(logLevel);
        permissionsResultListener = new PluginRegistry.RequestPermissionsResultListener() {
            @Override
            public boolean onRequestPermissionsResult(final int requestCode, @NonNull final String[] permissions, @NonNull final int[] grantResults) {
                Log.i(
                        LOG_TAG,
                        "RequestPermissionsResultListener"
                                + "\nrequestCode: " + requestCode
                                + "\npermissions: " + Arrays.toString(permissions)
                                + "\ngrantResults: " + Arrays.toString(grantResults)
                );
                if (eventSink != null) {
                    // Event has to be sent in JSON format, because
                    // sending an array is not supported by the MethodChannel API
                    // and triggers a runtime error.
                    eventSink.success(
                            "{\"requestCode\":" + requestCode
                                    + ", \"permissions\":" + Utils.toJSONArray(permissions)
                                    + ", \"grantResults\":" + Utils.toJSONArray(Utils.convert(grantResults))
                                    + "}"
                    );
                } else {
                    Log.e(LOG_TAG, "onRequestPermissionsResult, eventSink is null");
                }
                return true;
            }
        };
        // Todo: Finish activityResultListener
        activityResultListener = new PluginRegistry.ActivityResultListener() {
            @Override
            public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
//                resultCode is either
//                Activity.RESULT_OK = -1 or
//                Activity.RESULT_CANCELED = 0

                Log.i(
                        LOG_TAG,
                        "\n\nActivityResultListener"
                                + "\npermission: " + Manifest.permission.SYSTEM_ALERT_WINDOW
                                + "\nrequestCode: " + requestCode
                                + "\nresultCode: " + resultCode
                );

                if (eventSink != null) {
//                  Sending this as JSON format as well
//                  for compatibility reasons with the API
//                  on the Dart side.
                    eventSink.success(
                            "{\"requestCode\":" + requestCode
                                    + ", \"permissions\":" + Utils.toJSONArray(new String[]{Manifest.permission.SYSTEM_ALERT_WINDOW})
                                    + ", \"grantResults\":" + Utils.toJSONArray(new Integer[]{
                                    (Utils.hasPermissionSystemAlertWindow(activityBinding.getActivity())
                                            ? PackageManager.PERMISSION_GRANTED
                                            : PackageManager.PERMISSION_DENIED)
                            })
                                    + "}"
                    );
                } else {
                    Log.e(LOG_TAG, "onRequestPermissionsResult, eventSink is null");
                }
                return true;
            }
        };
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), METHODCHANNEL_ID);
        channel.setMethodCallHandler(this);
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), EVENTCHANNEL_ID);
        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        eventChannel.setStreamHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
        activityBinding.addRequestPermissionsResultListener(permissionsResultListener);
        activityBinding.addActivityResultListener(activityResultListener);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activityBinding.removeRequestPermissionsResultListener(permissionsResultListener);
        activityBinding.removeActivityResultListener(activityResultListener);
        activityBinding = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        activityBinding = binding;
        activityBinding.addRequestPermissionsResultListener(permissionsResultListener);
        activityBinding.addActivityResultListener(activityResultListener);
    }

    @Override
    public void onDetachedFromActivity() {
        activityBinding.removeRequestPermissionsResultListener(permissionsResultListener);
        activityBinding.removeActivityResultListener(activityResultListener);
        activityBinding = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "requestPermissions":

                final String[] permissions = Utils.listToArray(call.argument("permissions"));
                final int requestCode = call.argument("requestCode");

                if (activityBinding == null) {
                    Log.e(LOG_TAG, "requestMultipleAndroidPermissions, activityBinding is null");
                    result.error(null, "requestMultipleAndroidPermissions, activityBinding is null", null);
                } else if (permissions == null) {
                    Log.e(LOG_TAG, "requestMultipleAndroidPermissions, permissions is null");
                    result.error(null, "requestMultipleAndroidPermissions, permissions is null", null);
                } else {

                    // handle all other not yet granted permissions
                    if (permissions.length > 0) {
                        ActivityCompat.requestPermissions(
                                activityBinding.getActivity(),
                                permissions,
                                requestCode
                        );
                    }

                    result.success(null);
                }

                break;

            case "requestPermissionSystemAlertWindow":
                final int requestCode2 = call.argument("requestCode");

                Log.i(LOG_TAG, "requestPermissionSystemAlertWindow, requestCode: " + requestCode2);

                if (activityBinding == null) {
                    Log.e(LOG_TAG, "requestPermissionSystemAlertWindow, activityBinding is null");
                    result.error(null, "requestPermissionSystemAlertWindow, activityBinding is null", null);
                } else {
                    Utils.requestPermissionSystemAlertWindow(
                            activityBinding.getActivity(),
                            requestCode2
                    );
                    result.success(null);
                }

                break;

            case "hasPermission":
                final String permissionArg = call.argument("permission");

                if (activityBinding == null) {
                    Log.e(LOG_TAG, "hasPermission, activityBinding is null");
                    result.error(null, "hasPermission, activityBinding is null", null);
                } else if (permissionArg == null) {
                    Log.e(LOG_TAG, "hasPermission, permissionArg is null");
                    result.error(null, "hasPermission, permissionArg is null", null);
                } else {
                    final boolean hasPermission;

                    if (permissionArg.equals(Manifest.permission.SYSTEM_ALERT_WINDOW)) {
                        hasPermission = Utils.hasPermissionSystemAlertWindow(
                                activityBinding.getActivity()
                        );
                    } else {
                        hasPermission = Utils.hasPermission(
                                activityBinding.getActivity(),
                                permissionArg
                        );
                    }

                    Log.i(LOG_TAG, "hasPermission"
                            + "\npermission: " + permissionArg
                            + "\nhasPermission: " + hasPermission);

                    result.success(hasPermission);
                }
                break;

            case "setLogLevel":
                logLevel = call.argument("logLevel");
                Log.setLogLevel(logLevel);
                Log.i(LOG_TAG, "logLevel is now <" + logLevel + ">");
                result.success(null);
                break;

            default:
                result.notImplemented();
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

}

