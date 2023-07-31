







import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/api.dart';
import 'package:movie/models/series.dart';
import 'package:movie/services/series_service.dart';


final genreProvider = FutureProvider.autoDispose.family((ref , int id ) => GenreProvider.getGenreData(genreId: id));


class GenreProvider  {

  static Future<List<Series>> getGenreData ({required int genreId}) async{

    final data = await SeriesService.getSeriesByGenre(with_genres: genreId, apiPath: Api.getByGenre);
    return data.fold((l) => throw(l), (r) => r);



  }







}