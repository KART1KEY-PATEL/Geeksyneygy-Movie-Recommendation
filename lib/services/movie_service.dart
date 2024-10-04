import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String _url = 'https://hoblist.com/api/movieList';

  Future<dynamic> getMovieRecommendations() async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        body: {
          'category': 'movies',
          'language': 'kannada',
          'genre': 'all',
          'sort': 'voting',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON data
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load movie recommendations');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}