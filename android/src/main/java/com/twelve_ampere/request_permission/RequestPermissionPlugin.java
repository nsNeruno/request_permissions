package com.twelve_ampere.request_permission;

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

    private static final String NAMESPACE = "com.twelve_ampere.request_permission.RequestPermissionPlugin";
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
            public boolean onRequestPermissionsResult(final int requestCode, @NonNull final String[] permissions, @NonNull final int[] grantResults) {
                if (isLogLevelVerbose()) {
                    Log.i(LOG_TAG, "requestCode: " + requestCode
                            + "\npermissions: " + Arrays.toString(permissions)
                            + "\ngrantResults: " + Arrays.toString(grantResults));
                }
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
                    if (isLogLevelError())
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
        switch (call.method) {
            case "requestPermissions":

                final String[] permissions = Utils.listToArray(call.argument("permissions"));
                final int requestCode = call.argument("requestCode");
                final HashMap<String, Boolean> map = new HashMap<>();

                if (activity == null) {
                    if (isLogLevelError()) {
                        Log.e(LOG_TAG, "requestMultipleAndroidPermissions, activity is null");
                    }
                    result.error(null, "requestMultipleAndroidPermissions, activity is null", null);
                } else if (permissions == null) {
                    if (isLogLevelError()) {
                        Log.e(LOG_TAG, "requestMultipleAndroidPermissions, permissions is null");
                    }
                    result.error(null, "requestMultipleAndroidPermissions, permissions is null", null);
                } else {
                    if (permissions.length == 1) {
                        if (!Utils.hasPermission(activity, permissions[0])) {
                            ActivityCompat.requestPermissions(activity, permissions, requestCode);
                            map.put(permissions[0], false);
                        } else {
                            map.put(permissions[0], true);
                        }
                    } else {
                        final ArrayList<String> ungrantedPermissions = new ArrayList<>();
                        for (int i = 0; i < permissions.length; i++) {
                            final boolean has = Utils.hasPermission(activity, permissions[i]);
                            map.put(permissions[i], has);
                            if (!has) ungrantedPermissions.add(permissions[i]);
                        }
                        if (!ungrantedPermissions.isEmpty()) {
                            ActivityCompat.requestPermissions(
                                    activity,
                                    Utils.listToArray(ungrantedPermissions),
                                    requestCode
                            );
                        }
                    }
                    result.success(map);
                }

                break;

            case "hasPermission":
                final String hasPermission = call.argument("permission");

                if (activity == null) {
                    result.error(null, "onMethodCall, activity is null", null);
                    if (isLogLevelError()) Log.e(LOG_TAG, "onMethodCall, activity is null");
                } else {
                    result.success(Utils.hasPermission(activity, hasPermission));
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

