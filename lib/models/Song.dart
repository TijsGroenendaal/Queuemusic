class Song {
  final String album;
  final String songname;
  final String authors;
  final String id;

  Song(this.album, this.songname, this.authors, this.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "album": album,
      "songname": songname,
      "authors": authors,
      "id": id
    };
  }

  @override
  String toString() {
    return "{id: $id, songname: $songname, authors: $authors, album: $album}";
  }
}
