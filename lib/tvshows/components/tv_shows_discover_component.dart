import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/tvshows/pages/tv_shows_detail_page.dart';
import 'package:project/tvshows/providers/tv_shows_get_discover_provider.dart';
import 'package:project/widget/item_tv_shows_widget.dart';
import 'package:provider/provider.dart';

class TvShowsDiscoverComponent extends StatefulWidget {
  const TvShowsDiscoverComponent({super.key});

  @override
  State<TvShowsDiscoverComponent> createState() => _TvShowsDiscoverComponentState();
}

class _TvShowsDiscoverComponentState extends State<TvShowsDiscoverComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvShowsGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<TvShowsGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }

          if (provider.tvShows.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.tvShows.length,
              itemBuilder: (_, index, __) {
                final tvShows = provider.tvShows[index];
                return ItemTvShowsWidget(
                  tvShows: tvShows,
                  heightBackdrop: 300,
                  widthBackdrop: double.infinity,
                  heightPoster: 160,
                  widthPoster: 100,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) {
                        return TvShowsDetailPage(id: tvShows.id);
                      },
                    ));
                  },
                );
              },
              options: CarouselOptions(
                height: 300.0,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Not found discover tv shows',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
