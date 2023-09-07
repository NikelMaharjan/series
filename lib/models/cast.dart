
class Cast {

  final String name;
  final int id;
  final String profile_path;
  final String character;


  Cast({required this.name, required this.profile_path, required this.character, required this.id});


  factory Cast.fromJson (Map<String, dynamic> json){
    return Cast(
        id: json['id'],
        name: json['name'] ?? '',
        profile_path: json['profile_path'] == null ? '': 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['profile_path']}',
        character: json['character'] ?? ''
    );
  }

}