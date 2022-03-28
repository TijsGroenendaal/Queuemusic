import 'package:queuemusic/models/Song.dart';

abstract class StorageSolution {

  List<Song> loadSongs();
  void deleteSong(String songId);
  void addSong(Song song);

}