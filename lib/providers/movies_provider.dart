import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micartelera/models/credits_response.dart';
import 'package:micartelera/models/models.dart';
import 'package:micartelera/models/search_response.dart';
class MoviesProvider extends ChangeNotifier {

  String _apikey = 'e374ebad2940fe709a86a8eadbd5aff5';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Movie> OnDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;
  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData ( String endpoint, [int page = 1]) async {
     final url =
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
  Future<List<Cast>> getMovieCast(int movieId) async {
    
    // TOOD: revisar el mapa
    if ( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;
    
    // print('pidiendo info al servidor - Cast');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovies( String query) async {
    final url = Uri.https( _baseUrl, '3/search/movie',  {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;

  }



}