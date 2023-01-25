// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class NowPlayingResponse {
    NowPlayingResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));


    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    // Map<String, dynamic> toMap() => {
    //     "dates": dates.toMap(),
    //     "page": page,
    //     "results": List<dynamic>.from(results.map((x) => x.toMap())),
    //     "total_pages": totalPages,
    //     "total_results": totalResults,
    // };
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toMap() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}

// class Movie {
//     Movie({
//         required this.adult,
//         required this.backdropPath,
//         required this.genreIds,
//         required this.id,
//         required this.originalLanguage,
//         required this.originalTitle,
//         required this.overview,
//         required this.popularity,
//         required this.posterPath,
//         required this.releaseDate,
//         required this.title,
//         required this.video,
//         required this.voteAverage,
//         required this.voteCount,
//     });

//     bool adult;
//     String backdropPath;
//     List<int> genreIds;
//     int id;
//     OriginalLanguage originalLanguage;
//     String originalTitle;
//     String overview;
//     double popularity;
//     String posterPath;
//     DateTime releaseDate;
//     String title;
//     bool video;
//     double voteAverage;
//     int voteCount;

//     factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Movie.fromMap(Map<String, dynamic> json) => Movie(
//         adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originalLanguage: originalLanguageValues.map[json["original_language"]],
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"].toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: DateTime.parse(json["release_date"]),
//         title: json["title"],
//         video: json["video"],
//         voteAverage: json["vote_average"].toDouble(),
//         voteCount: json["vote_count"],
//     );

//     Map<String, dynamic> toMap() => {
//         "adult": adult,
//         "backdrop_path": backdropPath,
//         "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
//         "id": id,
//         "original_language": originalLanguageValues.reverse[originalLanguage],
//         "original_title": originalTitle,
//         "overview": overview,
//         "popularity": popularity,
//         "poster_path": posterPath,
//         "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
//         "title": title,
//         "video": video,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//     };
// }

// enum OriginalLanguage { EN, JA, RU }

// final originalLanguageValues = EnumValues({
//     "en": OriginalLanguage.EN,
//     "ja": OriginalLanguage.JA,
//     "ru": OriginalLanguage.RU
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
