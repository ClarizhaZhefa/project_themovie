import 'package:flutter/material.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsSearchProvider with ChangeNotifier {
  final TvShowsRepository _tvShowsRepository;

  TvShowsSearchProvider(this._tvShowsRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TvShowsModel> _tvShows = [];
  List<TvShowsModel> get tvShows => _tvShows;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvShowsRepository.search(query: query);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _tvShows.clear();
        _tvShows.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }
}
