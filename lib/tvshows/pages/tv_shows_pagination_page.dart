import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/tvshows/pages/tv_shows_detail_page.dart';
import 'package:project/tvshows/providers/tv_shows_get_airing_today_provider.dart';
import 'package:project/tvshows/providers/tv_shows_get_discover_provider.dart';
import 'package:project/tvshows/providers/tv_shows_top_rated_provider.dart';
import 'package:project/widget/item_tv_shows_widget.dart';
import 'package:provider/provider.dart';

enum TypeTvShows { discover, topRated, airingToday }

class TvShowsPaginationPage extends StatefulWidget {
  const TvShowsPaginationPage({super.key, required this.type});

  final TypeTvShows type;

  @override
  State<TvShowsPaginationPage> createState() => _TvShowsPaginationPageState();
}

class _TvShowsPaginationPageState extends State<TvShowsPaginationPage> {
  final PagingController<int, TvShowsModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      switch (widget.type) {
        case TypeTvShows.discover:
          context.read<TvShowsGetDiscoverProvider>().getDiscoverWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeTvShows.topRated:
          context.read<TvShowsGetTopRatedProvider>().getTopRatedWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
        case TypeTvShows.airingToday:
          context.read<TvShowsGetAiringTodayProvider>().getAiringTodayWithPaging(
                context,
                pagingController: _pagingController,
                page: pageKey,
              );
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeTvShows.discover:
              return const Text('Discover TV Shows');
            case TypeTvShows.topRated:
              return const Text('Top Rated TV Shows');
            case TypeTvShows.airingToday:
              return const Text('Airing Today TV Shows');
          }
        }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
        padding: const EdgeInsets.all(16.0),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<TvShowsModel>(
          itemBuilder: (context, item, index) => ItemTvShowsWidget(
            tvShows: item,
            heightBackdrop: 260,
            widthBackdrop: double.infinity,
            heightPoster: 140,
            widthPoster: 80,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return TvShowsDetailPage(id: item.id);
                },
              ));
            },
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
