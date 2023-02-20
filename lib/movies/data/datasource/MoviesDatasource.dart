
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_dev/movies/data/datasource/fake_data.dart';

import '../models/movie_model.dart';

abstract class MoviesDatasource {
  Future<List<MovieModel>> getMoviesList();

  Future<MovieModel> getMovieDetails(String id);
}

class MockMovieDatasource extends MoviesDatasource {

  @override
  Future<List<MovieModel>> getMoviesList() {
    return Future.delayed(Duration(seconds: 3), () => movies);
    // return Future.value(movies);
  }

  @override
  Future<MovieModel> getMovieDetails(String id) {
    return Future.value(movies.where((elem) => elem.id == id).first);
  }
}


class TruncatedDatasource extends MoviesDatasource {
  @override
  Future<MovieModel> getMovieDetails(String id) {
    return Future.error("");
  }

  @override
  Future<List<MovieModel>> getMovieList() {
    return Future.delayed(
      Duration(seconds: 2),
          // () => movies.where((element) => element.name.startsWith("A")).toList(),
          () => movies.where((element) => (element.releaseDate?.year == 2021)).toList(),
    );
  }

  @override
  Future<List<MovieModel>> getMoviesList() {
    // TODO: implement getMoviesList
    throw UnimplementedError();
  }
}

var moviesDatasource = Provider(
        (providerRef) => TruncatedDatasource()
);