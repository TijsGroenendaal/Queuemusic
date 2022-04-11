import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/helper/SnackbarHelper.dart';
import 'package:queuemusic/models/SessionSong.dart';

import '../models/Session.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({Key? key}) : super(key: key);

  @override
  _SessionWidgetState createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {

  late Session session;

  @override
  void initState() {
    session = Provider.of<Session>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            session.isHost ? IconButton(
                onPressed: () async {
                  session.closeSession();
                },
                icon: Icon(Icons.close)
            ) : IconButton(
                onPressed: () {
                  session.leaveSession();
                },
                icon: Icon(Icons.exit_to_app)
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("sessions")
            .doc(session.sessionCode).collection("songs")
            .orderBy("votes").snapshots(),
          builder: (context, queue) {
            if (queue.hasError) {
              return const Text("Something went wrong");
            }

            if (!queue.hasData) {
              return const Text("Loading...");
            }
            return ListView.separated(
              reverse: true,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: queue.data?.size ?? 0,
              itemBuilder: (context, index) {
                SessionSong song = SessionSong.fromDoc(queue.data!.docs[index], session.sessionCode);
                bool hasVoted = song.votedBy.where((element) => element == session.userSessionId).isNotEmpty;

                return ListTile(
                    title: Text("${song.songName}, ${song.album}"),
                    subtitle: Text("${song.authors}", style: const TextStyle(color: QueueMusicColor.grey),),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: session.userSessionId == song.user ? QueueMusicColor.white : QueueMusicColor.green,
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      ],
                    )
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          },
        ),
      ),
    );
  }
}
