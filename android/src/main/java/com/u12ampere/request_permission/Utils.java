package com.u12ampere.request_permission;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.Arrays;
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
        if (Build.VERSION.SDK_INT == Build.VERSION_CODES.N) {
            return (Integer[]) Arrays.stream(array).boxed().toArray();
        } else {
            Integer[] newArray = new Integer[array.length];
            for (int i = 0; i < array.length; i++) newArray[i] = array[i];
            return newArray;
        }
    }

    @Nullable
    public static String[] listToArray(Object object) {
        if (!(object instanceof List)) return null;
        final String[] array = new String[((List) object).size()];
        ((List) object).toArray(array);
        return array;
    }
}
