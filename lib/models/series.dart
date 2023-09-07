


enum Categories{
  trending,
  top_rated,
  upcpming
}


class Series{

  final String name;
  final int id;
  final String overview;
  final String first_air_date;
  final String poster_path;
  final String  vote_average;
  final String backdrop_path;
  final String popularity;
  final int vote_count;


  Series({
    required this.backdrop_path,
    required this.name,
    required this.id,
    required this.poster_path,
    required this.overview,
    required this.vote_average,
    required this.vote_count,
    required this.popularity,
    required this.first_air_date
    
  });

  factory Series.fromJson (Map <String, dynamic> json){
    return Series(
        name: json['name'] ?? '',
        id: json['id'] ?? '',
        backdrop_path: json['poster_path'] == null ?'' : 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['backdrop_path']}',
        poster_path: json['poster_path'] == null ? ' ':'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['backdrop_path']}',
        overview: json['overview'] ?? '',
        vote_average: json['vote_average'].toString() ?? '' ,
        vote_count: json['vote_count'] ?? 0 ,
        popularity: json['popularity'].toString() ?? '',
        first_air_date: json['first_air_date'] ?? '',
    );
  }








}