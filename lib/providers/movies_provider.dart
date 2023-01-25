
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:micartelera/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _apikey = 'e374ebad2940fe709a86a8eadbd5aff5';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> OnDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData ( String endpoint, [int page = 1]) async {
     var url =
      Uri.https(_baseUrl,endpoint , {
        'api_key': _apikey,
        'language': _language,
        'page': '$page'
      });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }



  getOnDisplayMovies() async {
    
    _popularPage ++ ;

    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    // print( nowPlayingResponse.results[1].title);

    OnDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); // para avisar a todos los widgets que utlizan la data, si se actualiza
  }

  getPopularMovies() async {

    _popularPage ++;
    
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
        
    final popularResponse = PopularReponse.fromJson(jsonData);

    print('tesa');
    print( popularResponse.results[1].title);
    print('peru');
    print( popularResponse.results.length);
    print('ecuador');
    popularMovies = [ ...popularMovies , ...popularResponse.results] ;


    notifyListeners(); // para avisar a todos los widgets que utlizan la data, si se actualiza

  }

}