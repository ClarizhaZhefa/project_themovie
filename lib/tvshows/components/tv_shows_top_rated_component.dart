import 'package:flutter/material.dart';
import 'package:project/tvshows/pages/tv_shows_detail_page.dart';
import 'package:project/tvshows/providers/tv_shows_top_rated_provider.dart';
import 'package:project/widget/image_widget.dart';
import 'package:provider/provider.dart';

class TvShowsTopRatedComponent extends StatefulWidget {
  const TvShowsTopRatedComponent({super.key});

  @override
  State<TvShowsTopRatedComponent> createState() => _TvShowsTopRatedComponentState();
}

class _TvShowsTopRatedComponentState extends State<TvShowsTopRatedComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvShowsGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<TvShowsGetTopRatedProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0)),
              );
            }

            if (provider.tvShows.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return ImageNetworkWidget(
                    imageSrc: provider.tvShows[index].posterPath,
                    height: 200,
                    width: 120,
                    radius: 12.0,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) {
                          return TvShowsDetailPage(id: provider.tvShows[index].id);
                        },
                      ));
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: 8.0,
                ),
                itemCount: provider.tvShows.length,
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text('Not found top rated tv shows'),
              ),
            );
          },
        ),
      ),
    );
  }
}

