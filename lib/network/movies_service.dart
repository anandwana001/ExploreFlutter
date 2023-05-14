import 'dart:async';
import 'dart:convert';
import '../model/movies_list.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;


class MoviesService {
  Future<MoviesList> fetchPopularMovies() async {
    var url =
    Uri.https(Endpoints.baseUrl, Endpoints.popularMovies, {'language': 'en-US', 'api_key': Endpoints.apiKey});
    final response = await http
        .get(url);

    if (response.statusCode == 200) {
      return MoviesList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}