package com.twelve_ampere.request_permission;

import android.Manifest;
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

    @NonNull
    public static <T> String toJSONArray(@Nullable T[] array) {
        if (array == null || array.length == 0) return "[]";

        StringBuilder jsonArrayString = new StringBuilder("[");
        for (int i = 0; i < array.length; i++) {
            jsonArrayString.append('"').append(array[i]).append('"');
            if (i + 1 < array.length) jsonArrayString.append(',');
        }
        return jsonArrayString.append(']').toString();
    }

    @NonNull
    public static <T> String toJSONArray(@Nullable T element) {
        if (null == element) return "[]";
        return "[\"" + element.toString() + "\"]";
    }

    public static Uri getIntentDataUri(Activity activity) {
        return Uri.parse("package:" + activity.getApplicationContext().getPackageName());
    }

    public static boolean isMarshmallowOrAbove() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M;
    }

    public static boolean isOreoOrAbove() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.O;
    }


}
