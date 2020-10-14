import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';



/*-------------------------------------------------------------------------------------------*/
/*                                 Some pre-defined methods                                  */
/*-------------------------------------------------------------------------------------------*/

String getEnumValue(dynamic enumVar) =>
    enumVar.toString().substring(enumVar.toString().lastIndexOf(".") + 1);

/// loads all images in assets/ folder
void preloadAllAssetImages() async {
  // TODO: Add your own assets
  //
  // example:
  //
  // const String assets = "assets/";
  // loadImage(assets + "test.png");
}

String getSimpleClassName(Object obj) => obj.toString();

/// percent has to be within [0;1]
double getWindowWidth({
  @required BuildContext context,
  @required double percent,
}) {
  assert(percent >= 0 || percent <= 1,
      "\ngetWindowWidth: percent has to be within [0;1]\n");

  return MediaQuery.of(context).size.width * percent;
}

/// percent has to be within [0;1]
double getWindowHeight({
  @required BuildContext context,
  @required double percent,
}) {
  assert(percent >= 0 || percent <= 1,
      "\ngetWindowWidth: percent has to be within [0;1]\n");

  return MediaQuery.of(context).size.height * percent;
}



Future<Uint8List> loadImage(String url) {
  ImageStreamListener listener;

  final Completer<Uint8List> completer = Completer<Uint8List>();
  final ImageStream imageStream =
      AssetImage(url).resolve(ImageConfiguration.empty);

  listener = ImageStreamListener(
    (ImageInfo imageInfo, bool synchronousCall) {
      imageInfo.image
          .toByteData(format: ImageByteFormat.png)
          .then((ByteData byteData) {
        imageStream.removeListener(listener);
        completer.complete(byteData.buffer.asUint8List());
      });
    },
    onError: (dynamic exception, StackTrace stackTrace) {
      imageStream.removeListener(listener);
      completer.completeError(exception);
    },
  );

  imageStream.addListener(listener);

  return completer.future;
}