import 'package:flutter/material.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      this.textEditingController,
      this.hintText,
      this.maxLength,
      this.enabled,
      {Key? key}
  ) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final int maxLength;
  final BoolWrapper enabled;


  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled.value(),
      controller: textEditingController,
      maxLength: maxLength,
      cursorColor: QueueMusicColor.white,
      style: const TextStyle(
        color: QueueMusicColor.white
      ),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: QueueMusicColor.green)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: QueueMusicColor.green)),

        hintStyle: theme().textTheme.subtitle2,
        hintText: hintText,
        counterStyle: theme().textTheme.subtitle2
      ),
    );

  }
}

class BoolWrapper {
  final bool _enabled;
  BoolWrapper(this._enabled);

  bool value() => _enabled;
}
