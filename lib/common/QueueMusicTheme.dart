import 'package:flutter/material.dart';

import 'QueueMusicColor.dart';

ThemeData theme() {
  return ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: QueueMusicColor.green750,
      elevation: 3,
    ),

    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(side:  const BorderSide(color: QueueMusicColor.green, width: 1), borderRadius: BorderRadius.circular(5)),
    ),


    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: QueueMusicColor.white,
      ),
      bodyText2: TextStyle(
        color: QueueMusicColor.white,
      ),
      subtitle1: TextStyle(
        color: QueueMusicColor.white,
      ),
      subtitle2: TextStyle(
        color: QueueMusicColor.white,
      )
    ),

    scaffoldBackgroundColor: QueueMusicColor.black,

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: QueueMusicColor.white,
      ),
      backgroundColor: QueueMusicColor.black600,
    ),

    backgroundColor: QueueMusicColor.black,

    iconTheme: IconThemeData(
      color: QueueMusicColor.green,
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: QueueMusicColor.green,
      shape: RoundedRectangleBorder(side:  const BorderSide(color: QueueMusicColor.green, width: 1), borderRadius: BorderRadius.circular(5)),
    )

  );
}