import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/helper/SnackbarHelper.dart';
import 'package:queuemusic/models/SessionSong.dart';
import 'package:queuemusic/widgets/QrShareWidget.dart';

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
          title: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.2))
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => QrShareWidget(sessionId: session.sessionCode,))
                );
              },
              icon: Icon(Icons.qr_code),
              label: Text("QR")
          ),
          actions: [
            session.isHost ? ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.2))
              ),
              onPressed: () async {
                session.closeSession();
              },
              icon: const Icon(Icons.close),
              label: const Text("Close session"),
            ) : ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.2))
              ),
              onPressed: () {
                session.leaveSession();
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text("Leave Session"),
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
                    title: Text("${song.songName}, ${song.authors}"),
                    subtitle: Text(song.album, style: const TextStyle(color: QueueMusicColor.grey),),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: session.userSessionId == song.user ? QueueMusicColor.white : QueueMusicColor.green,
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    trailing: Builder(
                      builder: (context) {
                        if (session.isHost) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(song.votes.toString()),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: QueueMusicColor.error,
                                onPressed: () {
                                  FirebaseFirestore.instance.collection("sessions")
                                      .doc(session.sessionCode).collection("songs").doc(queue.data!.docs[index].id).delete();
                                },
                              ),
                            ],
                          );
                        }
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                DocumentReference doc = queue.data!.docs[index].reference;
                                List<dynamic> votedBy = (await doc.get()).get("votedBy");
                                if (votedBy.where((element) => element == session.userSessionId ).isNotEmpty) {
                                  SnackbarHelper.deploy(const Text("Already voted"), context);
                                } else {
                                  doc.update({
                                    "votedBy": FieldValue.arrayUnion([session.userSessionId]),
                                    "votes" : FieldValue.increment(1),
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_upward),
                              color: hasVoted ? QueueMusicColor.white : QueueMusicColor.green,
                            ),
                            Text(song.votes.toString()),
                            IconButton(
                              onPressed: () async {
                                DocumentReference doc = queue.data!.docs[index].reference;
                                List<dynamic> votedBy = (await doc.get()).get("votedBy");
                                if (votedBy.where((element) => element == session.userSessionId ).isNotEmpty) {
                                  SnackbarHelper.deploy(const Text("Already voted"), context);
                                } else {
                                  doc.update({
                                    "votedBy": FieldValue.arrayUnion([session.userSessionId]),
                                    "votes" : FieldValue.increment(-1),
                                  });
                                }
                              },
                              icon: const Icon(Icons.arrow_downward),
                              color: hasVoted ? QueueMusicColor.white : QueueMusicColor.green,
                            )
                          ],
                        );
                      }
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
