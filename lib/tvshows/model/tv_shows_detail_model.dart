class TvShowsDetailModel {
    final bool adult;
    final String backdropPath;
    final DateTime firstAirDate;
    final List<Genre> genres;
    final String homepage;
    final int id;
    final DateTime lastAirDate;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final String overview;
    final double popularity;
    final String posterPath;
    final String status;
    final String tagline;
    final double voteAverage;
    final int voteCount;

    TvShowsDetailModel({
        required this.adult,
        this.backdropPath = '',
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.lastAirDate,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.overview,
        required this.popularity,
        this.posterPath = '',
        required this.status,
        required this.tagline,
        required this.voteAverage,
        required this.voteCount,
    });

    factory TvShowsDetailModel.fromMap(Map<String, dynamic> json) => TvShowsDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        lastAirDate: DateTime.parse(json["last_air_date"]),
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
