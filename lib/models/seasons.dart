


class Season{
  final String status;
  final List<Episode> seasons;
  final List<Network> networks;
  final List<Genre> genres;

  Season({required this.status, required this.seasons, required this.networks, required this.genres});

  factory Season.fromJson(Map<String, dynamic> json){
    return Season(
      status: json['status'],
      networks: (json['networks'] as List).map((e) => Network.fromJson(e)).toList(),
      seasons: (json['seasons'] as List).map((e) => Episode.fromJson(e)).toList(),
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList()

    );
  }

}


class Network{
  final String name;
  final String logo_path;
  final int id;

  Network({required this.name, required this.logo_path, required this.id});

  factory Network.fromJson(Map<String, dynamic> json){
    return Network(
        id: json['id'],
        name: json['name'] ?? '',
        logo_path: json['logo_path'] == null ? '' : 'https://image.tmdb.org/t/p/w500${json['logo_path']}',
    );
  }
}

class Episode{

  final String air_date;
  final String name;
  final int season_number;
  final int episode_count;

  Episode({required this.air_date, required this.name, required this.season_number, required this.episode_count});
  factory Episode.fromJson(Map<String, dynamic> json){
    return Episode(
        air_date: json['air_date'] ?? 'Not Confirmed',
        name: json['name'] ?? '',
        episode_count: json['episode_count'] ?? '',
        season_number: json['season_number'] ?? '',
    );

  }

}


class Genre {
  final int id;
  final String name;

  Genre ({required this.id, required this.name});


  factory Genre.fromJson (Map<String, dynamic> json){
    return Genre(
        id: json['id'],
        name: json['name']
    );

  }

}




