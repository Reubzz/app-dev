
import 'package:flutter/material.dart';
import 'package:mobile_app_dev/movies/data/datasource/MoviesDatasource.dart';
import '../../../common/ui/pages/AbsListPageWidget.dart';
import '../../data/models/movie_model.dart';

class MovieListPage extends StatelessWidget {
  final List<MovieModel> movieList;

  MovieListPage(this.movieList) : super();
  @override
  Widget build(BuildContext context) {
    return AbsListPageWidget<MovieModel>(
        // items: movieList,
        title: "Movies",
      getList: () => MockMovieDatasource().getMoviesList(),
      itemBuilder: (ctx, item) => _MovieCardWidget(item: item),
    );
  }
}




class _MovieCardWidget extends StatelessWidget {
  final MovieModel item;

  const _MovieCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(item.name, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text("${item.contentRating} ${item.duration}", style: Theme.of(context).textTheme.bodySmall),

              ],
          )
      ),
    );

  }
}