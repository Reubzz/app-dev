
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