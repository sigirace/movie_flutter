class MovieModel {
  final int id;
  final String title;
  final String backdropPath;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        backdropPath = json['backdrop_path'];
}
