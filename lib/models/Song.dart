class Song {
  final String album;
  final String songName;
  final String authors;
  final String id;

  Song(this.album, this.songName, this.authors, this.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "album": album,
      "songName": songName,
      "authors": authors,
      "id": id
    };
  }
}
