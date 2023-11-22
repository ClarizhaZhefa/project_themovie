class TvShowsResponseModel {
    final int page;
    final List<TvShowsModel> results;
    final int totalPages;
    final int totalResults;

    TvShowsResponseModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory TvShowsResponseModel.fromMap(Map<String, dynamic> json) => 
      TvShowsResponseModel(
        page: json["page"],
        results: List<TvShowsModel>.from(json["results"].map((x) => TvShowsModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

class TvShowsModel {
    final String? backdropPath;
    final int id;
    final String name;
    final String overview;
    final double popularity;
    final String? posterPath;
    final double voteAverage;
    final int voteCount;

    TvShowsModel({
        this.backdropPath,
        required this.id,
        required this.name,
        required this.overview,
        required this.popularity,
        this.posterPath,
        required this.voteAverage,
        required this.voteCount,
    });

    factory TvShowsModel.fromMap(Map<String, dynamic> json) => TvShowsModel(
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        name: json["name"], 
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? '',
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

}
