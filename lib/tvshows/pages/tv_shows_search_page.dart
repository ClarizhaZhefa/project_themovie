import 'package:flutter/material.dart';
import 'package:project/tvshows/pages/tv_shows_detail_page.dart';
import 'package:project/tvshows/providers/tv_shows_search_provider.dart';
import 'package:project/widget/image_widget.dart';
import 'package:provider/provider.dart';

class TvShowsSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search TV Shows";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<TvShowsSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<TvShowsSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(child: Text("Search TV"));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.tvShows.isEmpty) {
          return const Center(child: Text("TV Shows Not Found"));
        }

        if (provider.tvShows.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final tvShows = provider.tvShows[index];
              return Stack(
                children: [
                  Row(
                    children: [
                      ImageNetworkWidget(
                        imageSrc: tvShows.posterPath,
                        height: 120,
                        width: 80,
                        radius: 10,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvShows.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              tvShows.overview,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          close(context, null);
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
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: provider.tvShows.length,
          );
        }

        return const Center(child: Text("Another Error on search tv shows"));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
