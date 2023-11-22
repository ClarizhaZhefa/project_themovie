import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project/app_constants.dart';
import 'package:project/movie/providers/movie_get_detail_provider.dart';
import 'package:project/movie/providers/movie_get_discover_provider.dart';
import 'package:project/movie/providers/movie_get_now_playing_discover.dart';
import 'package:project/movie/providers/movie_get_top_rated_provider.dart';
import 'package:project/movie/providers/movie_get_videos_provider.dart';
import 'package:project/movie/providers/movie_search_provider.dart';
import 'package:project/movie/repostories/movie_repository.dart';
import 'package:project/movie/repostories/movie_repository_impl.dart';
import 'package:project/tvshows/providers/tv_shows_get_detail_provider.dart';
import 'package:project/tvshows/providers/tv_shows_get_discover_provider.dart';
import 'package:project/tvshows/providers/tv_shows_get_videos_provider.dart';
import 'package:project/tvshows/providers/tv_shows_search_provider.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';
import 'package:project/tvshows/repostories/tv_shows_repository_impl.dart';

import 'tvshows/providers/tv_shows_get_airing_today_provider.dart';
import 'tvshows/providers/tv_shows_top_rated_provider.dart';

final sl = GetIt.instance;

void setup() {
  // Register Provider
  sl.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(sl()),
  );
  sl.registerFactory<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(sl()),
  );
  sl.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(sl()),
  );
  sl.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(sl()),
  );
  sl.registerFactory<MovieGetVideosProvider>(
    () => MovieGetVideosProvider(sl()),
  );
  sl.registerFactory<MovieSearchProvider>(
    () => MovieSearchProvider(sl()),
  );
  sl.registerFactory<TvShowsGetDiscoverProvider>(
    () => TvShowsGetDiscoverProvider(sl()),
  );
  sl.registerFactory<TvShowsGetTopRatedProvider>(
    () => TvShowsGetTopRatedProvider(sl()),
  );
  sl.registerFactory<TvShowsGetAiringTodayProvider>(
    () => TvShowsGetAiringTodayProvider(sl()),
  );
  sl.registerFactory<TvShowsGetDetailProvider>(
    () => TvShowsGetDetailProvider(sl()),
  );
  sl.registerFactory<TvShowsGetVideosProvider>(
    () => TvShowsGetVideosProvider(sl()),
  );
  sl.registerFactory<TvShowsSearchProvider>(
    () => TvShowsSearchProvider(sl()),
  );

  // Register Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));
  sl.registerLazySingleton<TvShowsRepository>(() => TvShowsRepositoryImpl(sl()));

  // Register Http Client (DIO)
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );
}
