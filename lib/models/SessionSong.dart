import 'package:cloud_firestore/cloud_firestore.dart';

class SessionSong {
  late final String songName;
  late final String authors;
  late final String album;
  late final int votes;
  late final String user;
  late final List<dynamic> votedBy;

  SessionSong.fromDoc(DocumentSnapshot doc, String sessionCode) {
    try {
      songName = (doc.data() as dynamic)['songName'] ?? "Not defined";
      authors = (doc.data() as dynamic)['authors'] ?? "Not defined";
      album = (doc.data() as dynamic)['album'] ?? "Not defined";
      votes = (doc.data() as dynamic)['votes'] ?? 0;
      user = (doc.data() as dynamic)['user'] ?? "Not defined";
      votedBy = (doc.data() as dynamic)['votedBy'] ?? [];
    } catch(e) {
      doc.reference.delete();
    }
  }

  SessionSong(this.songName, this.authors, this.album, this.user) {
    votedBy = [];
    votes = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      "songName" : songName,
      "authors" : authors,
      "album" : album,
      "votes" : 0,
      "user" : user,
      "votedBy": votedBy
    };
  }
}