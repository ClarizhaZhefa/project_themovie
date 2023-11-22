import 'package:flutter/material.dart';
import 'package:project/tvshows/pages/tv_shows_detail_page.dart';
import 'package:project/tvshows/providers/tv_shows_get_airing_today_provider.dart';
import 'package:project/widget/image_widget.dart';
import 'package:provider/provider.dart';

class TvShowsAiringTodayComponent extends StatefulWidget {
  const TvShowsAiringTodayComponent({super.key});

  @override
  State<TvShowsAiringTodayComponent> createState() =>
      _TvShowsAiringTodayComponentState();
}

class _TvShowsAiringTodayComponentState extends State<TvShowsAiringTodayComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvShowsGetAiringTodayProvider>().getAiringToday(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<TvShowsGetAiringTodayProvider>(
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
                  final tvShows = provider.tvShows[index];

                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageNetworkWidget(
                              imageSrc: tvShows.posterPath,
                              height: 200,
                              width: 120,
                              radius: 12.0,
                            ),
                            const SizedBox(width: 8.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tvShows.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        '${tvShows.voteAverage} (${tvShows.voteCount})',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    tvShows.overview,
                                    maxLines: 3,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) {
                                  return TvShowsDetailPage(id: tvShows.id);
                                },
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
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
                child: Text('Not found airing today tv shows'),
              ),
            );
          },
        ),
      ),
    );
  }
}
