import 'package:flutter/material.dart';
import 'package:project/tvshows/model/tv_shows_video_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsGetVideosProvider with ChangeNotifier {
  final TvShowsRepository _tvShowsRepository;

  TvShowsGetVideosProvider(this._tvShowsRepository);

  TvShowsVideosModel? _videos;
  TvShowsVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _tvShowsRepository.getVideos(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _videos = null;
        notifyListeners();
        return;
      },
      (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}
