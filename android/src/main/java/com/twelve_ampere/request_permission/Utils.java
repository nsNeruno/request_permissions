package com.twelve_ampere.request_permission;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import java.util.List;

public final class Utils {
    public static boolean hasPermission(Activity activity, String permission) {
        return ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED;
    }

    public static <T> String toJSONArray(@Nullable T[] array) {
        if (array == null || array.length == 0) return "[]";

        StringBuilder jsonArrayString = new StringBuilder("[");
        for (int i = 0; i < array.length; i++) {
            jsonArrayString.append('"').append(array[i]).append('"');
            if (i + 1 < array.length) jsonArrayString.append(',');
        }
        return jsonArrayString.append(']').toString();
    }

    public static Integer[] convert(@NonNull int[] array) {
        Integer[] newArray = new Integer[array.length];
        for (int i = 0; i < array.length; i++) newArray[i] = array[i];
        return newArray;
    }

    @Nullable
    @SuppressWarnings("unchecked")
    public static String[] listToArray(Object object) {
        if (!(object instanceof List<?>)) return null;
        final String[] array = new String[((List<String>) object).size()];
        ((List<String>) object).toArray(array);
        return array;
    }

    /**
     * Use this function to request the permission
     * {@link android.Manifest.permission#SYSTEM_ALERT_WINDOW}.
     * <p>
     * Returns true, if the permissions has already been granted or
     * the {@link Build.VERSION#SDK_INT} is lower than {@link Build.VERSION_CODES#M},
     * else false.
     */
    public static boolean requestPermissionSystemAlertWindow(Activity activity, int requestCode) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
                && !hasPermissionSystemAlertWindow(activity)) {
            Intent intent = new Intent(
                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                    Uri.parse("package:" + activity.getApplicationContext().getPackageName())
            );
            activity.startActivityForResult(intent, requestCode);
            return false;
        }
        return true;
    }

    /**
     * The permission {@link android.Manifest.permission#SYSTEM_ALERT_WINDOW} gets
     * automatically granted <b>if {@link Utils#isMarshmallowOrAbove()} is false</b> and
     * the app was downloaded from the Google PlayStore.
     * <br>
     * <b>If {@link Utils#isMarshmallowOrAbove()} is true</b>, then
     * {@link Settings#canDrawOverlays(Context)} has to be evaluated
     * to see if the user granted this app the permission
     * {@link android.Manifest.permission#SYSTEM_ALERT_WINDOW}.
     * <br>
     * <br>
     * <a href="https://stackoverflow.com/a/36019034">
     * Additional explanation.
     * </a>
     */
    public static boolean hasPermissionSystemAlertWindow(Activity activity) {
        return !isMarshmallowOrAbove() ||
                Settings.canDrawOverlays(activity.getApplicationContext());
    }

    public static boolean isMarshmallowOrAbove() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M;
    }

}
