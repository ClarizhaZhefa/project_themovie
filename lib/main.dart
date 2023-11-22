import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/app_constants.dart';
import 'package:project/injector.dart';
import 'package:project/movie/model/movie_model.dart';
import 'package:project/movie/pages/movie_page.dart';
import 'package:project/movie/providers/movie_get_discover_provider.dart';
import 'package:project/movie/providers/movie_get_now_playing_discover.dart';
import 'package:project/movie/providers/movie_get_top_rated_provider.dart';
import 'package:project/movie/providers/movie_search_provider.dart';
import 'package:project/movie/repostories/movie_repository.dart';
import 'package:project/movie/repostories/movie_repository_impl.dart';
import 'package:project/tvshows/providers/tv_shows_get_discover_provider.dart';
import 'package:project/tvshows/providers/tv_shows_search_provider.dart';
import 'package:provider/provider.dart';

import 'tvshows/providers/tv_shows_get_airing_today_provider.dart';
import 'tvshows/providers/tv_shows_top_rated_provider.dart';

void main() {
  setup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
           create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<TvShowsGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<TvShowsGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<TvShowsGetAiringTodayProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<TvShowsSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'THEMOVIE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
