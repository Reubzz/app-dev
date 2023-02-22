
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_dev/movies/data/datasource/MoviesDatasource.dart';
import 'package:mobile_app_dev/movies/ui/pages/MovieDetailsPageWidget.dart';
import '../../../common/ui/pages/AbsListPageWidget.dart';
import '../../data/models/movie_model.dart';


class MovieListPage extends ConsumerWidget {
  MovieListPage() : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AbsListPageWidget<MovieModel>(
      title: "Movies",
      getList: () => ref.read(moviesDatasource).getMoviesList(),
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
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MovieDetailsPageWidget(movieId: item.id)
        )),
        child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: min(constraints.maxWidth * 0.25, 120),
                      child: CachedNetworkImage(
                          imageUrl: item.posterUrl
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Rating: ${item.contentRating}   Duration: ${item.duration}   Released: ${item.releaseDate?.year}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(item.genres.join(", "))
                      ],
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
