


class SeasonDetails {

final String air_date;
final int episode_number;
final String name;
final String overview;
final int runtime;



SeasonDetails({required this.air_date, required this.episode_number, required this.name, required this.overview, required this.runtime});


factory SeasonDetails.fromJson (Map<String, dynamic> json){

  return SeasonDetails(
      air_date: json['air_date'] ?? '',
      episode_number: json['episode_number'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      runtime: json['runtime'] ?? 0
  );

}


}