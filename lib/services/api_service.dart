import 'package:final_project/models/movie_detail_model.dart';
import 'package:final_project/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getMovies(String endpoint) async {
    List<MovieModel> movieInstances = [];
    final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      var results = data['results'];
      for (var result in results) {
        movieInstances.add(MovieModel.fromJson(result));
      }
      return movieInstances;
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final respnse = await http.get(url);
    if (respnse.statusCode == 200) {
      final movie = jsonDecode(respnse.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
