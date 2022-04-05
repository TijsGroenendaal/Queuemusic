import 'package:queuemusic/models/Song.dart';

abstract class StorageSolution {

  Future<List<Song>> loadSongs();
  Future<void> deleteSong(String songId);
  Future<void> addSong(Song song);

}