// To parse this JSON data, do
//
//     final popularReponse = popularReponseFromMap(jsonString);

import 'dart:convert';

import 'package:micartelera/models/models.dart';

class PopularReponse {
    PopularReponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PopularReponse.fromJson(String str) => PopularReponse.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory PopularReponse.fromMap(Map<String, dynamic> json) => PopularReponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    // Map<String, dynamic> toMap() => {
    //     "page": page,
    //     "results": List<dynamic>.from(results.map((x) => x.toMap())),
    //     "total_pages": totalPages,
    //     "total_results": totalResults,
    // };
}
