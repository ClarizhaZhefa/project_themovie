import 'package:flutter/material.dart';
import 'package:project/injector.dart';
import 'package:project/tvshows/providers/tv_shows_get_detail_provider.dart';
import 'package:project/tvshows/providers/tv_shows_get_videos_provider.dart';
import 'package:project/widget/image_widget.dart';
import 'package:project/widget/item_tv_shows_widget.dart';
import 'package:project/widget/webview_widget.dart';
import 'package:project/widget/youtube_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvShowsDetailPage extends StatelessWidget {
  const TvShowsDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<TvShowsGetDetailProvider>()..getDetail(context, id: id),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              sl<TvShowsGetVideosProvider>()..getVideos(context, id: id),
        ),
      ],
      builder:(_,__)=> Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            Consumer<TvShowsGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;
                if (videos != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                      title: 'Trailer',
                      padding: 0,
                      body: 
                      videos.results.isEmpty
                      ? Center(
                          child: Text('No videos available'),
                        )
                      : SizedBox(
                        height: 160,
                        child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                            final vidio = videos.results[index];
                            return Stack(
                              children: [
                                ImageNetworkWidget(
                                  radius: 12,
                                  type: TypeSrcImg.external,
                                  imageSrc: YoutubePlayer.getThumbnail(
                                  videoId: vidio.key,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          6.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => YoutubePlayerWidget(
                                              youtubeKey: vidio.key,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: videos.results.length,
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => Colors.black;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<TvShowsGetDetailProvider>(
          builder: (_, provider, __) {
            final tvShows = provider.tvShows;

            if (tvShows != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewWidget(
                            title: tvShows.name,
                            url: tvShows.homepage,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.public),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ];

  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace => Consumer<TvShowsGetDetailProvider>(
        builder: (_, provider, __) {
          final tvShows = provider.tvShows;

          if (tvShows != null) {
            return ItemTvShowsWidget(
              tvShowsDetail: tvShows,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 160.0,
              widthPoster: 100.0,
              radius: 0,
            );
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
  );
}

class _Content extends StatelessWidget {
  const _Content(
      {required this.title, required this.body, this.padding = 16.0});

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({
    required String title, 
    required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ]);

  @override
  Widget? get child => Consumer<TvShowsGetDetailProvider>(
        builder: (_, provider, __) {
          final tvShows = provider.tvShows;

          if (tvShows != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Content(
                      title: 'First Air Date',
                      body: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            size: 32.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            tvShows.firstAirDate.toString().split(' ').first,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _Content(
                    title: 'Last Air Date',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          size: 32.0,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          tvShows.lastAirDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
                _Content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 6,
                    children: tvShows.genres
                        .map((genre) => Chip(label: Text(genre.name)))
                        .toList(),
                  ),
                ),
                _Content(title: 'Overview', body: Text(tvShows.overview)),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                        title: "Adult",
                        content: tvShows.adult ? "Yes" : "No",
                      ),
                      _tableContent(
                        title: "Popularity",
                        content: '${tvShows.popularity}',
                      ),
                      _tableContent(
                        title: "Status",
                        content: tvShows.status,
                      ),
                      _tableContent(
                        title: "Number of Episodes",
                        content: "${tvShows.numberOfEpisodes}",
                      ),
                      _tableContent(
                        title: "Number of Seasons",
                        content: "${tvShows.numberOfSeasons}",
                      ),
                      _tableContent(
                        title: "Tagline",
                        content: tvShows.tagline,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15)
              ],
            );
          }

          return Container();
        },
      );
}
