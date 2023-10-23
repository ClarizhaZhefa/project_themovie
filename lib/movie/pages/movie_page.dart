import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/app_constants.dart';
import 'package:project/movie/components/movie_discover_component.dart';
import 'package:project/movie/components/movie_get_now_playing_component.dart';
import 'package:project/movie/components/movie_top_rated_component.dart';
import 'package:project/movie/model/movie_model.dart';
import 'package:project/movie/pages/movie_pagination_page.dart';
import 'package:project/movie/providers/movie_get_discover_provider.dart';
import 'package:project/movie/providers/movie_get_top_rated_provider.dart';
import 'package:project/widget/image_widget.dart';
import 'package:project/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
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
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => TvPage(),
            //   ),
            // );
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
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
           _WidgetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.discover,
                  ),
                ),
              );
            },
          ),
          const MovieDiscoverComponent(),
          _WidgetTitle(
            title: 'Top Rated Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.topRated,
                  ),
                ),
              );
            },
          ),
          const MovieTopRatedComponent(),
          _WidgetTitle(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MoviePaginationPage(
                    type: TypeMovie.nowPlaying,
                  ),
                ),
              );
            },
          ),
          const MovieNowPlayingComponent(),
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

