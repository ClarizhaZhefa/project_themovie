import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsGetTopRatedProvider with ChangeNotifier {
  final TvShowsRepository _tvShowsRepository;

  TvShowsGetTopRatedProvider(this._tvShowsRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<TvShowsModel> _tvShows = [];
  List<TvShowsModel> get tvShows => _tvShows;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvShowsRepository.getTopRated();

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );

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

  void getTopRatedWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _tvShowsRepository.getTopRated(page: page);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        pagingController.error = messageError;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return;
      },
    );
  }
}
