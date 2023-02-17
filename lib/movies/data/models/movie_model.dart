class MovieModel {
  final String id, name;
  final DateTime? releaseDate;
  final String contentRating, duration, description, posterUrl;
  final List<String> formats, languages, genres, cast;
  final String? rating, likes;
  final String? urlBook;

  MovieModel({
    required this.id,
    required this.name,
    this.releaseDate,
    required this.duration,
    required this.contentRating,
    required this.description,
    required this.posterUrl,
    required this.formats,
    required this.languages,
    required this.genres,
    required this.cast,
    this.rating,
    this.likes,
    this.urlBook,
  });
}