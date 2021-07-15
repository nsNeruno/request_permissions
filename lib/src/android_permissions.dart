part of request_permission;

/// This class lists all permissions from android.
///
/// [Source](https://developer.android.com/reference/android/Manifest.permission)
abstract class AndroidPermissions {
  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCEPT_HANDOVER)
  static const String acceptHandover = "android.permission.ACCEPT_HANDOVER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_BACKGROUND_LOCATION)
  static const String accessBackgroundLocation =
      "android.permission.ACCESS_BACKGROUND_LOCATION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_CHECKIN_PROPERTIES)
  static const String accessCheckinProperties =
      "android.permission.ACCESS_CHECKIN_PROPERTIES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_COARSE_LOCATION)
  static const String accessCoarseLocation =
      "android.permission.ACCESS_COARSE_LOCATION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_FINE_LOCATION)
  static const String accessFineLocation =
      "android.permission.ACCESS_FINE_LOCATION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_LOCATION_EXTRA_COMMANDS)
  static const String accessLocationExtraCommands =
      "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_MEDIA_LOCATION)
  static const String accessMediaLocation =
      "android.permission.ACCESS_MEDIA_LOCATION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_NETWORK_STATE)
  static const String accessNetworkState =
      "android.permission.ACCESS_NETWORK_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_NOTIFICATION_POLICY)
  static const String accessNotificationPolicy =
      "android.permission.ACCESS_NOTIFICATION_POLICY";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCESS_WIFI_STATE)
  static const String accessWifiState = "android.permission.ACCESS_WIFI_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACCOUNT_MANAGER)
  static const String accountManager = "android.permission.ACCOUNT_MANAGER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ACTIVITY_RECOGNITION)
  static const String activityRecognition =
      "android.permission.ACTIVITY_RECOGNITION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ADD_VOICEMAIL)
  static const String addVoicemail = "android.permission.ADD_VOICEMAIL";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#ANSWER_PHONE_CALLS)
  static const String answerPhoneCalls =
      "android.permission.ANSWER_PHONE_CALLS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BATTERY_STATS)
  static const String batteryStats = "android.permission.BATTERY_STATS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_ACCESSIBILITY_SERVICE)
  static const String bindAccessibilityService =
      "android.permission.BIND_ACCESSIBILITY_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_APPWIDGET)
  static const String bindAppwidget = "android.permission.BIND_APPWIDGET";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_AUTOFILL_SERVICE)
  static const String bindAutofillService =
      "android.permission.BIND_AUTOFILL_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CALL_REDIRECTION_SERVICE)
  static const String bindCallRedirectionService =
      "android.permission.BIND_CALL_REDIRECTION_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CARRIER_MESSAGING_CLIENT_SERVICE)
  @Deprecated(
      "\n\nThis constant was deprecated in API level 23. Use bindCarrierServices instead")
  static const String bindCarrierMessagingClientService =
      "android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CARRIER_MESSAGING_SERVICE)
  static const String bindCarrierMessagingService =
      "android.permission.BIND_CARRIER_MESSAGING_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CARRIER_SERVICES)
  static const String bindCarrierServices =
      "android.permission.BIND_CARRIER_SERVICES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CHOOSER_TARGET_SERVICE)
  @Deprecated(
      "\n\nThis constant was deprecated in API level 30. For publishing direct share targets, please follow the instructions in https://developer.android.com/training/sharing/receive.html#providing-direct-share-targets instead")
  static const String bindChooserTargetService =
      "android.permission.BIND_CHOOSER_TARGET_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_COMPANION_DEVICE_SERVICE)
  static const String bindCompanionDeviceService =
      "android.permission.BIND_COMPANION_DEVICE_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CONDITION_PROVIDER_SERVICE)
  static const String bindConditionProviderService =
      "android.permission.BIND_CONDITION_PROVIDER_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_CONTROLS)
  static const String bindControls = "android.permission.BIND_CONTROLS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_DEVICE_ADMIN)
  static const String bindDeviceAdmin = "android.permission.BIND_DEVICE_ADMIN";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_DREAM_SERVICE)
  static const String bindDreamService =
      "android.permission.BIND_DREAM_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_INCALL_SERVICE)
  static const String bindIncallService =
      "android.permission.BIND_INCALL_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_INPUT_METHOD)
  static const String bindInputMethod = "android.permission.BIND_INPUT_METHOD";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_MIDI_DEVICE_SERVICE)
  static const String bindMidiDeviceService =
      "android.permission.BIND_MIDI_DEVICE_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_NFC_SERVICE)
  static const String bindNfcService = "android.permission.BIND_NFC_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_NOTIFICATION_LISTENER_SERVICE)
  static const String bindNotificationListenerService =
      "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_PRINT_SERVICE)
  static const String bindPrintService =
      "android.permission.BIND_PRINT_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_QUICK_ACCESS_WALLET_SERVICE)
  static const String bindQuickAccessWalletService =
      "android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_QUICK_SETTINGS_TILE)
  static const String bindQuickSettingsTile =
      "android.permission.BIND_QUICK_SETTINGS_TILE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_REMOTEVIEWS)
  static const String bindRemoteviews = "android.permission.BIND_REMOTEVIEWS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_SCREENING_SERVICE)
  static const String bindScreeningService =
      "android.permission.BIND_SCREENING_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_TELECOM_CONNECTION_SERVICE)
  static const String bindTelecomConnectionService =
      "android.permission.BIND_TELECOM_CONNECTION_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_TEXT_SERVICE)
  static const String bindTextService = "android.permission.BIND_TEXT_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_TV_INPUT)
  static const String bindTvInput = "android.permission.BIND_TV_INPUT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_VISUAL_VOICEMAIL_SERVICE)
  static const String bindVisualVoicemailService =
      "android.permission.BIND_VISUAL_VOICEMAIL_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_VOICE_INTERACTION)
  static const String bindVoiceInteraction =
      "android.permission.BIND_VOICE_INTERACTION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_VPN_SERVICE)
  static const String bindVpnService = "android.permission.BIND_VPN_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_VR_LISTENER_SERVICE)
  static const String bindVrListenerService =
      "android.permission.BIND_VR_LISTENER_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BIND_WALLPAPER)
  static const String bindWallpaper = "android.permission.BIND_WALLPAPER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BLUETOOTH)
  static const String bluetooth = "android.permission.BLUETOOTH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BLUETOOTH_ADMIN)
  static const String bluetoothAdmin = "android.permission.BLUETOOTH_ADMIN";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BLUETOOTH_PRIVILEGED)
  static const String bluetoothPrivileged =
      "android.permission.BLUETOOTH_PRIVILEGED";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BODY_SENSORS)
  static const String bodySensors = "android.permission.BODY_SENSORS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BROADCAST_PACKAGE_REMOVED)
  static const String broadcastPackageRemoved =
      "android.permission.BROADCAST_PACKAGE_REMOVED";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BROADCAST_SMS)
  static const String broadcastSms = "android.permission.BROADCAST_SMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BROADCAST_STICKY)
  static const String broadcastSticky = "android.permission.BROADCAST_STICKY";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#BROADCAST_WAP_PUSH)
  static const String broadcastWapPush =
      "android.permission.BROADCAST_WAP_PUSH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CALL_COMPANION_APP)
  static const String callCompanionApp =
      "android.permission.CALL_COMPANION_APP";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CALL_PHONE)
  static const String callPhone = "android.permission.CALL_PHONE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CALL_PRIVILEGED)
  static const String callPrivileged = "android.permission.CALL_PRIVILEGED";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CAMERA)
  static const String camera = "android.permission.CAMERA";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CAPTURE_AUDIO_OUTPUT)
  static const String captureAudioOutput =
      "android.permission.CAPTURE_AUDIO_OUTPUT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CHANGE_COMPONENT_ENABLED_STATE)
  static const String changeComponentEnabledState =
      "android.permission.CHANGE_COMPONENT_ENABLED_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CHANGE_CONFIGURATION)
  static const String changeConfiguration =
      "android.permission.CHANGE_CONFIGURATION";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CHANGE_NETWORK_STATE)
  static const String changeNetworkState =
      "android.permission.CHANGE_NETWORK_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CHANGE_WIFI_MULTICAST_STATE)
  static const String changeWifiMulticastState =
      "android.permission.CHANGE_WIFI_MULTICAST_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CHANGE_WIFI_STATE)
  static const String changeWifiState = "android.permission.CHANGE_WIFI_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CLEAR_APP_CACHE)
  static const String clearAppCache = "android.permission.CLEAR_APP_CACHE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#CONTROL_LOCATION_UPDATES)
  static const String controlLocationUpdates =
      "android.permission.CONTROL_LOCATION_UPDATES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#DELETE_CACHE_FILES)
  static const String deleteCacheFiles =
      "android.permission.DELETE_CACHE_FILES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#DELETE_PACKAGES)
  static const String deletePackages = "android.permission.DELETE_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#DIAGNOSTIC)
  static const String diagnostic = "android.permission.DIAGNOSTIC";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#DISABLE_KEYGUARD)
  static const String disableKeyguard = "android.permission.DISABLE_KEYGUARD";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#DUMP)
  static const String dump = "android.permission.DUMP";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#EXPAND_STATUS_BAR)
  static const String expandStatusBar = "android.permission.EXPAND_STATUS_BAR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#FACTORY_TEST)
  static const String factoryTest = "android.permission.FACTORY_TEST";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#FOREGROUND_SERVICE)
  static const String foregroundService =
      "android.permission.FOREGROUND_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#GET_ACCOUNTS)
  static const String getAccounts = "android.permission.GET_ACCOUNTS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#GET_ACCOUNTS_PRIVILEGED)
  static const String getAccountsPrivileged =
      "android.permission.GET_ACCOUNTS_PRIVILEGED";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#GET_PACKAGE_SIZE)
  static const String getPackageSize = "android.permission.GET_PACKAGE_SIZE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#GET_TASKS)
  static const String getTasks = "android.permission.GET_TASKS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#GLOBAL_SEARCH)
  static const String globalSearch = "android.permission.GLOBAL_SEARCH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#HIDE_OVERLAY_WINDOWS)
  static const String hideOverlayWindows =
      "android.permission.HIDE_OVERLAY_WINDOWS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INSTALL_LOCATION_PROVIDER)
  static const String installLocationProvider =
      "android.permission.INSTALL_LOCATION_PROVIDER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INSTALL_PACKAGES)
  static const String installPackages = "android.permission.INSTALL_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INSTALL_SHORTCUT)
  static const String installShortcut = "android.permission.INSTALL_SHORTCUT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INSTANT_APP_FOREGROUND_SERVICE)
  static const String instantAppForegroundService =
      "android.permission.INSTANT_APP_FOREGROUND_SERVICE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INTERACT_ACROSS_PROFILES)
  static const String interactAcrossProfiles =
      "android.permission.INTERACT_ACROSS_PROFILES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#INTERNET)
  static const String internet = "android.permission.INTERNET";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#KILL_BACKGROUND_PROCESSES)
  static const String killBackgroundProcesses =
      "android.permission.KILL_BACKGROUND_PROCESSES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#LOADER_USAGE_STATS)
  static const String loaderUsageStats =
      "android.permission.LOADER_USAGE_STATS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#LOCATION_HARDWARE)
  static const String locationHardware = "android.permission.LOCATION_HARDWARE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MANAGE_DOCUMENTS)
  static const String manageDocuments = "android.permission.MANAGE_DOCUMENTS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MANAGE_EXTERNAL_STORAGE)
  static const String manageExternalStorage =
      "android.permission.MANAGE_EXTERNAL_STORAGE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MANAGE_ONGOING_CALLS)
  static const String manageOngoingCalls =
      "android.permission.MANAGE_ONGOING_CALLS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MANAGE_OWN_CALLS)
  static const String manageOwnCalls = "android.permission.MANAGE_OWN_CALLS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MASTER_CLEAR)
  static const String masterClear = "android.permission.MASTER_CLEAR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MEDIA_CONTENT_CONTROL)
  static const String mediaContentControl =
      "android.permission.MEDIA_CONTENT_CONTROL";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MODIFY_AUDIO_SETTINGS)
  static const String modifyAudioSettings =
      "android.permission.MODIFY_AUDIO_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MODIFY_PHONE_STATE)
  static const String modifyPhoneState =
      "android.permission.MODIFY_PHONE_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MOUNT_FORMAT_FILESYSTEMS)
  static const String mountFormatFilesystems =
      "android.permission.MOUNT_FORMAT_FILESYSTEMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#MOUNT_UNMOUNT_FILESYSTEMS)
  static const String mountUnmountFilesystems =
      "android.permission.MOUNT_UNMOUNT_FILESYSTEMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#NFC)
  static const String nfc = "android.permission.NFC";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#NFC_PREFERRED_PAYMENT_INFO)
  static const String nfcPreferredPaymentInfo =
      "android.permission.NFC_PREFERRED_PAYMENT_INFO";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#NFC_TRANSACTION_EVENT)
  static const String nfcTransactionEvent =
      "android.permission.NFC_TRANSACTION_EVENT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#PACKAGE_USAGE_STATS)
  static const String packageUsageStats =
      "android.permission.PACKAGE_USAGE_STATS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#PERSISTENT_ACTIVITY)
  static const String persistentActivity =
      "android.permission.PERSISTENT_ACTIVITY";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#PROCESS_OUTGOING_CALLS)
  static const String processOutgoingCalls =
      "android.permission.PROCESS_OUTGOING_CALLS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#QUERY_ALL_PACKAGES)
  static const String queryAllPackages =
      "android.permission.QUERY_ALL_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_CALENDAR)
  static const String readCalendar = "android.permission.READ_CALENDAR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_CALL_LOG)
  static const String readCallLog = "android.permission.READ_CALL_LOG";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_CONTACTS)
  static const String readContacts = "android.permission.READ_CONTACTS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_EXTERNAL_STORAGE)
  static const String readExternalStorage =
      "android.permission.READ_EXTERNAL_STORAGE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_INPUT_STATE)
  static const String readInputState = "android.permission.READ_INPUT_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_LOGS)
  static const String readLogs = "android.permission.READ_LOGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_PHONE_NUMBERS)
  static const String readPhoneNumbers =
      "android.permission.READ_PHONE_NUMBERS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_PHONE_STATE)
  static const String readPhoneState = "android.permission.READ_PHONE_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_PRECISE_PHONE_STATE)
  static const String readPrecisePhoneState =
      "android.permission.READ_PRECISE_PHONE_STATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_SMS)
  static const String readSms = "android.permission.READ_SMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_SYNC_SETTINGS)
  static const String readSyncSettings =
      "android.permission.READ_SYNC_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_SYNC_STATS)
  static const String readSyncStats = "android.permission.READ_SYNC_STATS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#READ_VOICEMAIL)
  static const String readVoicemail = "android.permission.READ_VOICEMAIL";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REBOOT)
  static const String reboot = "android.permission.REBOOT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RECEIVE_BOOT_COMPLETED)
  static const String receiveBootCompleted =
      "android.permission.RECEIVE_BOOT_COMPLETED";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RECEIVE_MMS)
  static const String receiveMms = "android.permission.RECEIVE_MMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RECEIVE_SMS)
  static const String receiveSms = "android.permission.RECEIVE_SMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RECEIVE_WAP_PUSH)
  static const String receiveWapPush = "android.permission.RECEIVE_WAP_PUSH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RECORD_AUDIO)
  static const String recordAudio = "android.permission.RECORD_AUDIO";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REORDER_TASKS)
  static const String reorderTasks = "android.permission.REORDER_TASKS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_COMPANION_PROFILE_WATCH)
  static const String requestCompanionProfileWatch =
      "android.permission.REQUEST_COMPANION_PROFILE_WATCH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_COMPANION_RUN_IN_BACKGROUND)
  static const String requestCompanionRunInBackground =
      "android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_COMPANION_USE_DATA_IN_BACKGROUND)
  static const String requestCompanionUseDataInBackground =
      "android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_DELETE_PACKAGES)
  static const String requestDeletePackages =
      "android.permission.REQUEST_DELETE_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
  static const String requestIgnoreBatteryOptimizations =
      "android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_INSTALL_PACKAGES)
  static const String requestInstallPackages =
      "android.permission.REQUEST_INSTALL_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE)
  static const String requestObserveCompanionDevicePresence =
      "android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#REQUEST_PASSWORD_COMPLEXITY)
  static const String requestPasswordComplexity =
      "android.permission.REQUEST_PASSWORD_COMPLEXITY";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#RESTART_PACKAGES)
  static const String restartPackages = "android.permission.RESTART_PACKAGES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SEND_RESPOND_VIA_MESSAGE)
  static const String sendRespondViaMessage =
      "android.permission.SEND_RESPOND_VIA_MESSAGE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SEND_SMS)
  static const String sendSms = "android.permission.SEND_SMS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_ALARM)
  static const String setAlarm = "android.permission.SET_ALARM";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_ALWAYS_FINISH)
  static const String setAlwaysFinish = "android.permission.SET_ALWAYS_FINISH";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_ANIMATION_SCALE)
  static const String setAnimationScale =
      "android.permission.SET_ANIMATION_SCALE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_DEBUG_APP)
  static const String setDebugApp = "android.permission.SET_DEBUG_APP";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_PREFERRED_APPLICATIONS)
  static const String setPreferredApplications =
      "android.permission.SET_PREFERRED_APPLICATIONS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_PROCESS_LIMIT)
  static const String setProcessLimit = "android.permission.SET_PROCESS_LIMIT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_TIME)
  static const String setTime = "android.permission.SET_TIME";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_TIME_ZONE)
  static const String setTimeZone = "android.permission.SET_TIME_ZONE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_WALLPAPER)
  static const String setWallpaper = "android.permission.SET_WALLPAPER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SET_WALLPAPER_HINTS)
  static const String setWallpaperHints =
      "android.permission.SET_WALLPAPER_HINTS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SIGNAL_PERSISTENT_PROCESSES)
  static const String signalPersistentProcesses =
      "android.permission.SIGNAL_PERSISTENT_PROCESSES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SMS_FINANCIAL_TRANSACTIONS)
  static const String smsFinancialTransactions =
      "android.permission.SMS_FINANCIAL_TRANSACTIONS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#START_VIEW_PERMISSION_USAGE)
  static const String startViewPermissionUsage =
      "android.permission.START_VIEW_PERMISSION_USAGE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#STATUS_BAR)
  static const String statusBar = "android.permission.STATUS_BAR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#SYSTEM_ALERT_WINDOW)
  static const String systemAlertWindow =
      "android.permission.SYSTEM_ALERT_WINDOW";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#TRANSMIT_IR)
  static const String transmitIr = "android.permission.TRANSMIT_IR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#UNINSTALL_SHORTCUT)
  static const String uninstallShortcut =
      "android.permission.UNINSTALL_SHORTCUT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#UPDATE_DEVICE_STATS)
  static const String updateDeviceStats =
      "android.permission.UPDATE_DEVICE_STATS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#USE_BIOMETRIC)
  static const String useBiometric = "android.permission.USE_BIOMETRIC";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#USE_FINGERPRINT)
  static const String useFingerprint = "android.permission.USE_FINGERPRINT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#USE_FULL_SCREEN_INTENT)
  static const String useFullScreenIntent =
      "android.permission.USE_FULL_SCREEN_INTENT";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER)
  static const String useIccAuthWithDeviceIdentifier =
      "android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#USE_SIP)
  static const String useSip = "android.permission.USE_SIP";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#VIBRATE)
  static const String vibrate = "android.permission.VIBRATE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WAKE_LOCK)
  static const String wakeLock = "android.permission.WAKE_LOCK";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_APN_SETTINGS)
  static const String writeApnSettings =
      "android.permission.WRITE_APN_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_CALENDAR)
  static const String writeCalendar = "android.permission.WRITE_CALENDAR";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_CALL_LOG)
  static const String writeCallLog = "android.permission.WRITE_CALL_LOG";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_CONTACTS)
  static const String writeContacts = "android.permission.WRITE_CONTACTS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_EXTERNAL_STORAGE)
  static const String writeExternalStorage =
      "android.permission.WRITE_EXTERNAL_STORAGE";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_GSERVICES)
  static const String writeGservices = "android.permission.WRITE_GSERVICES";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_SECURE_SETTINGS)
  static const String writeSecureSettings =
      "android.permission.WRITE_SECURE_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_SETTINGS)
  static const String writeSettings = "android.permission.WRITE_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_SYNC_SETTINGS)
  static const String writeSyncSettings =
      "android.permission.WRITE_SYNC_SETTINGS";

  /// [See](https://developer.android.com/reference/android/Manifest.permission#WRITE_VOICEMAIL)
  static const String writeVoicemail = "android.permission.WRITE_VOICEMAIL";
}
