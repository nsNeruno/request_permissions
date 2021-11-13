part of '../request_permission.dart';

const _namespace =
    "com.twelve_ampere.request_permission.RequestPermissionPlugin";
const _methodChannelId = "$_namespace.methods";
const _eventChannelId = "$_namespace.events";

const _channel = MethodChannel(_methodChannelId);
const _eventChannel = EventChannel(_eventChannelId);
