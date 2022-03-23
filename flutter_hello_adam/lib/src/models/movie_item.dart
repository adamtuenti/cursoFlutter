class MovieItem {
  int? page;
  List<Results>? results;
  int? totalResults;
  int? totalPages;

  MovieItem({this.page, this.results, this.totalResults, this.totalPages});

  MovieItem.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    print(data);
    return data;
  }
}

class Results {
  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  List<num>? genreIds;
  num? id;
  String? originalTitle;
  String? originalLanguage;
  late String title;
  String? backdropPath;
  double? popularity;
  num? voteCount;
  bool? video;
  double? voteAverage;
  String? description;

  Results(
      {this.posterPath,
        this.adult,
        this.overview,
        this.releaseDate,
        this.genreIds,
        this.id,
        this.originalTitle,
        this.originalLanguage,
        required this.title,
        this.backdropPath,
        this.popularity,
        this.voteCount,
        this.video,
        required this.description,
        this.voteAverage});

  Results.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    genreIds = json['genre_ids'].cast<num>();
    id = json['id'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    voteCount = json['vote_count'];
    video = json['video'];
    description = json['description'];
    voteAverage = 1;
  }

  get posterUrl => null;


  get vote => null;

  get movieId => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_path'] = this.posterPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_title'] = this.originalTitle;
    data['original_language'] = this.originalLanguage;
    data['title'] = this.title;
    data['backdrop_path'] = this.backdropPath;
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['description'] = this.description;
    data['vote_average'] = 1;
    return data;
  }
}