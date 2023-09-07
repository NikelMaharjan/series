
class CastDetail {

  final String biography;
  final String birthday;
  final int gender;
  final String name;
  final String place_of_birth;
  final String profile_path;


  CastDetail({required this.biography, required this.birthday, required this.gender, required this.name, required this.place_of_birth, required this.profile_path});

  factory CastDetail.fromJson (Map<String, dynamic> json){

    return CastDetail(
        biography: json['biography'] ?? '',
        birthday: json['birthday'] ?? '',
        gender: json['gender'] ?? 0,
        name: json['name'] ?? '',
        place_of_birth: json['place_of_birth'] ?? '',
      profile_path: json['profile_path'] == null ? '': 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['profile_path']}',
    );
  }

}
