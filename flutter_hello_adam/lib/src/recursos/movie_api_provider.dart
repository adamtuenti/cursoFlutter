import 'package:flutter_hello_adam/src/models/trailer_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hello_adam/src/models/movie_item.dart';
import 'dart:convert';

class MovieApiProvider {
  final apiKey = '61d52916517be688165b813a61c8dc7e';
  final baseUrl = 'https://api.themoviedb.org/3';

  Future<MovieItem> getMovieList() async{
    final urlPopular = '${baseUrl}/movie/popular?api_key=${apiKey}';

    final response = await http.get(Uri.parse(urlPopular));
    if(response.statusCode == 200){
      return MovieItem.fromJson(json.decode(response.body));

    }else{
      throw Exception('fallo en lo de las peliculas');
    }
  }

  Future<TrailerItem> getVideos(int movieId) async{
    final response = await http.get(Uri.parse("$baseUrl/movie/$movieId/videos?api_key=$apiKey"));
    if(response.statusCode == 200){
      return TrailerItem.fromJson(json.decode(response.body));

    }else{
      throw Exception('fallo videos');
    }

  }
}