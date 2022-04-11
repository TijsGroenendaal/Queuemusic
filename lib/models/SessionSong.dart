import 'package:cloud_firestore/cloud_firestore.dart';

class SessionSong {
  late final String songName;
  late final String authors;
  late final String album;
  late final String user;

  SessionSong.fromDoc(DocumentSnapshot doc, String sessionCode) {
    try {
      songName = (doc.data() as dynamic)['songName'] ?? "Not defined";
      authors = (doc.data() as dynamic)['authors'] ?? "Not defined";
      album = (doc.data() as dynamic)['album'] ?? "Not defined";
      user = (doc.data() as dynamic)['user'] ?? "Not defined";
    } catch(e) {
      doc.reference.delete();
    }
  }

  SessionSong(this.songName, this.authors, this.album, this.user) {
  }

  Map<String, dynamic> toMap() {
    return {
      "songName" : songName,
      "authors" : authors,
      "album" : album,
      "user" : user,
    };
  }
}