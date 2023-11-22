import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/movie/pages/movie_page.dart';
import 'package:project/movie/pages/movie_search_page.dart';
import 'package:project/tvshows/components/tv_shows_airing_today_component.dart';
import 'package:project/tvshows/components/tv_shows_discover_component.dart';
import 'package:project/tvshows/components/tv_shows_top_rated_component.dart';
import 'package:project/tvshows/pages/tv_shows_pagination_page.dart';
import 'package:project/tvshows/pages/tv_shows_search_page.dart';
import 'package:project/tvshows/providers/tv_shows_get_discover_provider.dart';
import 'package:provider/provider.dart';

class TvShowsPage extends StatelessWidget {
  const TvShowsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 63,
        backgroundColor: Colors.white,
        color: Color.fromARGB(70, 0, 0, 0),
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MoviePage(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => TvShowsPage(),
              ),
            );
          }
        },
        items: [
          Icon(
            Icons.movie_creation_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.tv_rounded,
            color: Colors.white,
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/icon1.png'),)
                ),
                Text('THEMOVIE'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context, 
                  delegate: TvShowsSearchPage(),
                ), 
                icon: const Icon(Icons.search))
            ],
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
           _WidgetTitle(
            title: 'Discover TV Shows',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TvShowsPaginationPage(
                    type: TypeTvShows.discover,
                  ),
                ),
              );
            },
          ),
          const TvShowsDiscoverComponent(),
          _WidgetTitle(
            title: 'Top Rated TV Shows',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TvShowsPaginationPage(
                    type: TypeTvShows.topRated,
                  ),
                ),
              );
            },
          ),
          const TvShowsTopRatedComponent(),
          _WidgetTitle(
            title: 'Airing Today TV Shows',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TvShowsPaginationPage(
                    type: TypeTvShows.airingToday,
                  ),
                ),
              );
            },
          ),
          const TvShowsAiringTodayComponent(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      )
    );
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Colors.black54,
                ),
              ),
              child: const Text('See All'),
            )
          ],
        ),
      );
}

