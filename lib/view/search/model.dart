import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:kamino/api.dart' as api;

class Movie {
  final String mediaType;
  final int id, pageCount;
  final String title, posterPath,backdropPath, year;

  Movie(this.mediaType, this.id, this.title,
      this.posterPath, this.backdropPath, this.year, this.pageCount);

  String get tv => mediaType;
  String get checkPoster => posterPath;
  int get showID => id;

  Movie.fromJson(Map json)
      : mediaType = json["media_type"], id = json["id"],
        title = json["original_name"] != null ?
        json["original_name"]: json["original_title"],
        pageCount = json["total_pages"],
        posterPath = json["poster_path"],
        backdropPath = json["backdrop_path"],
        year = json["release_date"] == null ?
        json["first_air_date"] :  json["release_date"];
}

class API {
  final http.Client _client = http.Client();

  static const String _url =
      "https://api.themoviedb.org/3/search/multi?"
      "api_key=${api.tvdb_api_key}&language=en-US"
      "&query={1}&include_adult=false";

  Future<List<Movie>>  get(String query) async {
    List<Movie> list = [];

    await _client
        .get(Uri.parse(_url.replaceFirst("{1}", query)))
        .then((res) => res.body)
        .then(jsonDecode)
        .then((json) => json["results"])
        .then((movies) => movies.forEach((movie) => list.add(Movie.fromJson(movie))));

    list.removeWhere((item) => item.mediaType != "movie" && item.mediaType != "tv");
    list.removeWhere((item) => item.id == null);

    return list;
  }
}