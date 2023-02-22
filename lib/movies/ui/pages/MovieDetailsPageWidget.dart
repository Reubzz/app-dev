

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_dev/common/ui/pages/AbsPageWidget.dart';
import 'package:mobile_app_dev/movies/data/datasource/MoviesDatasource.dart';
import 'package:mobile_app_dev/movies/data/models/movie_model.dart';

class MovieDetailsPageWidget extends ConsumerWidget {
  final String movieId;
  const MovieDetailsPageWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AbsPageWidget(
        title: "Movie",
        getData: () => ref.read(moviesDatasource).getMovieDetails(this.movieId),
        dataBuilder: (ctx, movie) {
          return LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.25,
                        child: CachedNetworkImage(
                          imageUrl: movie.posterUrl
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Rating: ${movie.contentRating}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Duration: ${movie.duration}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Duration: ${movie.releaseDate?.day}/${movie.releaseDate?.month}/${movie.releaseDate?.year}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}

