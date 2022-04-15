import 'package:queuemusic/helper/StorageSolution.dart';

import '../models/Song.dart';
import 'DataHelper.dart';

class Cache implements StorageSolution {
  late Duration _cacheValidationDuration;
  late DateTime _lastFetchTime;
  
  late List<Song> _likedSongs;

  Cache() {
    _lastFetchTime = DateTime.now();
    _cacheValidationDuration = const Duration(minutes: 15);
    _likedSongs = [];
    refresh().then((value) => _likedSongs = value);
  }

  @override
  Future<List<Song>> getSongs() async {
    bool shouldRefresh = (_lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidationDuration)));
    if (shouldRefresh) {
      await refresh();
    }
    return _likedSongs;
  }

  Future<List<Song>> refresh() async {
    _lastFetchTime = DateTime.now();
    _likedSongs = await DataHelper.db!.getSongs();
    return _likedSongs;
  }

  @override
  Future<void> deleteSong(String id) async {
    bool shouldRefresh = (_lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidationDuration)));
    if (shouldRefresh) {
      await refresh();
    }

    _likedSongs.removeWhere((element) => element.id == id);
    DataHelper.db!.deleteSong(id);
  }

  @override
  Future<void> addSong(Song song) async {
    bool shouldRefresh = (_lastFetchTime.isBefore(DateTime.now().subtract(_cacheValidationDuration)));
    if (shouldRefresh) {
      await refresh();
    }
    
    _likedSongs.add(song);
    DataHelper.db!.addSong(song);
  }
}