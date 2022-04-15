import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';

class QrShareWidget extends StatelessWidget {
  const QrShareWidget({Key? key, required this.sessionId}) : super(key: key);

  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SessionID: " + sessionId),
      ),
      body: Center(
        child: QrImage(
          data: sessionId,
          version: 1,
          backgroundColor: QueueMusicColor.white,
          foregroundColor: QueueMusicColor.black,
          gapless: false,
          errorStateBuilder: (cxt, err) {
            return const Center(
              child: Text("Something went wrong..."),
            );
          },
        ),
      ),
    );
  }
}
