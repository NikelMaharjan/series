


class NetworkInfo{


  final String headquarters;
  final String homepage;
  final int id;
  final String logo_path;
  final String name;
  final String origin_country;

  NetworkInfo({required this.name, required this.headquarters, required this.logo_path, required this.id, required this.homepage, required this.origin_country});


  factory NetworkInfo.fromJson(Map<String, dynamic> json){

    return NetworkInfo(
        name: json['name'],
        headquarters: json['headquarters'],
        logo_path: 'https://image.tmdb.org/t/p/w500${json['logo_path']}',
        id: json['id'],
        homepage: json['homepage'],
        origin_country: json['origin_country'],
    );
  }







}