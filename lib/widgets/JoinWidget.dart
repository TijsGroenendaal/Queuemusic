import 'package:flutter/material.dart';
import 'package:queuemusic/widgets/QrScannerWidget.dart';

class JoinWidget extends StatefulWidget {
  const JoinWidget({Key? key}) : super(key: key);

  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Session"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => QrScannerWidget()
                    ));
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Scan QR")
              )
            ],
          )
      ),

    );
  }
}
