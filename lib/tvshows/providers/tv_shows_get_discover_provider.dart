import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsGetDiscoverProvider with ChangeNotifier {
  final TvShowsRepository _tvShowsRepository;

  TvShowsGetDiscoverProvider(this._tvShowsRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;       

  final List<TvShowsModel> _tvShows = [];
  List<TvShowsModel> get tvShows => _tvShows;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _tvShowsRepository.getDiscover();

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
        return null;
      },
    );
  }

  void getDiscoverWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _tvShowsRepository.getDiscover(page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
        pagingController.error = errorMessage;
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