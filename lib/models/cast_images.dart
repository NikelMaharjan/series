



class CastImages {

  final String file_path;


  CastImages({required this.file_path});


  factory CastImages.fromJson (Map<String, dynamic> json) {

    return CastImages(
      file_path: json['file_path'] == null ? '': 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['file_path']}',

    );

  }


}