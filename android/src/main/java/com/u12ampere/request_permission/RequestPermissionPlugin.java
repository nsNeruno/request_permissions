package com.u12ampere.request_permission;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

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

    private static final String NAMESPACE = "com.u12ampere.request_permission.RequestPermissionPlugin";
    private static final String METHODCHANNEL_ID = NAMESPACE + ".methods";
    private static final String EVENTCHANNEL_ID = NAMESPACE + ".events";

    private MethodChannel channel;
    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;

    private Activity activity;
    private int logLevel;
    private final PluginRegistry.RequestPermissionsResultListener permissionsResultListener;

    public RequestPermissionPlugin() {
        // initialize logLevel with 0, which stands for verbose
        logLevel = 0;
        permissionsResultListener = new PluginRegistry.RequestPermissionsResultListener() {
            @Override
            public boolean onRequestPermissionsResult(final int requestCode, final String[] permissions, final int[] grantResults) {
                if (isLogLevelVerbose()) Log.i(LOG_TAG, "requestCode: " + requestCode
                        + "\npermissions: " + (permissions != null ? Arrays.toString(permissions) : null)
                        + "\ngrantResults: " + (grantResults != null ? Arrays.toString(grantResults) : null));
                if (eventSink != null) {
                    eventSink.success(
                            "{\"requestCode\":" + requestCode +
                                    ", \"permissions\":" + Utils.toJSONArray(permissions) +
                                    ", \"grantResults\":" + Utils.toJSONArray(Utils.convert(grantResults)) + "}"
                    );
                } else {
                    if (isLogLevelError())
                        Log.e(LOG_TAG, "onRequestPermissionsResult, eventSink is null");
                }
                return true;
            }
        };
        Log.i(LOG_TAG, "RequestPermissionPlugin Constructor");
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
        activity = binding.getActivity();
        binding.addRequestPermissionsResultListener(permissionsResultListener);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Log.i(LOG_TAG, "onMethodCall, call.method: " + call.method);
        switch (call.method) {
            case "requestAndroidPermission":
                final String permission1 = call.argument("permission");
                final int requestCode1 = call.argument("requestCode");
                final boolean checkIfAlreadyHas1 = call.argument("checkIfAlreadyHas");

                if (activity == null) {
                    result.error(null, "requestAndroidPermission, activity is null", null);
                    if (isLogLevelError())
                        Log.e(LOG_TAG, "requestAndroidPermission, activity is null");
                } else {
                    if (checkIfAlreadyHas1) {

                        if (Utils.hasPermission(activity, permission1)) {
                            // The permission has already been granted,
                            // so return TRUE
                            result.success(true);
                        } else {
                            // Request Permission
                            ActivityCompat.requestPermissions(
                                    activity,
                                    new String[]{permission1},
                                    requestCode1
                            );

                            // The permission has NOT already been granted,
                            // so return FALSE
                            result.success(false);
                        }

                    } else {
                        result.success(Utils.hasPermission(activity, permission1));
                        // Request Permission
                        ActivityCompat.requestPermissions(
                                activity,
                                new String[]{permission1},
                                requestCode1
                        );
                    }
                }
                break;

            case "requestMultipleAndroidPermissions":
                final String[] permissions2 = Utils.listToArray(call.argument("permissions"));
                final int requestCode2 = call.argument("requestCode");
                final HashMap<String, Boolean> map = new HashMap<>();

                if (activity == null) {
                    result.error(null, "requestMultipleAndroidPermissions, activity is null", null);
                    if (isLogLevelError())
                        Log.e(LOG_TAG, "requestMultipleAndroidPermissions, activity is null");
                } else if (permissions2 == null) {
                    result.error(null, "requestMultipleAndroidPermissions, permissions2 is null", null);
                    if (isLogLevelError())
                        Log.e(LOG_TAG, "requestMultipleAndroidPermissions, permissions2 is null");
                } else {
                    if (permissions2.length == 1) {
                        if (!Utils.hasPermission(activity, permissions2[0])) {
                            ActivityCompat.requestPermissions(activity, permissions2, requestCode2);
                            map.put(permissions2[0], false);
                        } else {
                            map.put(permissions2[0], true);
                        }
                    } else {
                        final ArrayList<String> ungrantedPermissions = new ArrayList<>();
                        for (int i = 0; i < permissions2.length; i++) {
                            final boolean has = Utils.hasPermission(activity, permissions2[i]);
                            map.put(permissions2[i], has);
                            if (!has) ungrantedPermissions.add(permissions2[i]);
                        }
                        if (!ungrantedPermissions.isEmpty()) {
                            ActivityCompat.requestPermissions(
                                    activity,
                                    Utils.listToArray(ungrantedPermissions),
                                    requestCode2
                            );
                        }
                    }
                    result.success(map);
                }

                break;

            case "hasAndroidPermission":
                final String permission3 = call.argument("permission");

                if (activity == null) {
                    result.error(null, "onMethodCall, activity is null", null);
                    if (isLogLevelError()) Log.e(LOG_TAG, "onMethodCall, activity is null");
                } else {
                    result.success(Utils.hasPermission(activity, permission3));
                }
                break;

            case "setLogLevel":
                logLevel = call.argument("logLevel");
                if (isLogLevelVerbose()) Log.i(LOG_TAG, "logLevel is now <" + logLevel + ">");
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

    //**************************** Private Functions ****************************//

    private boolean isLogLevelVerbose() {
        return logLevel == 0;
    }

    private boolean isLogLevelError() {
        return logLevel == 1 || isLogLevelVerbose();
    }
}

