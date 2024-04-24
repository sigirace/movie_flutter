class MovieDetailModel {
  final String title, overview, runtime, posterPath, genres;
  final double voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        voteAverage = json['vote_average'].toDouble(),
        runtime = json['runtime'].toString(),
        posterPath = json['poster_path'],
        genres = json['genres'].map((e) => e['name']).join(", ");
}
