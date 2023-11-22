import 'package:flutter/material.dart';
import 'package:project/tvshows/model/tv_shows_detail_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsGetDetailProvider with ChangeNotifier {
  final TvShowsRepository _tvShowsRepository;

  TvShowsGetDetailProvider(this._tvShowsRepository);

  TvShowsDetailModel? _tvShows;
  TvShowsDetailModel? get tvShows => _tvShows;

  void getDetail(BuildContext context, {required int id}) async {
    _tvShows = null;
    notifyListeners();
    final result = await _tvShowsRepository.getDetail(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _tvShows = null;
        notifyListeners();
        return;
      },
      (response) {
        _tvShows = response;
        notifyListeners();
        return;
      },
    );
  }
}