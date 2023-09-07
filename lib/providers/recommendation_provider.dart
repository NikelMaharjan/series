



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/series.dart';
import 'package:movie/services/series_service.dart';


final recommendationProvider = FutureProvider.autoDispose.family((ref , int id ) => RecommendationProvider.getRecommendationData(id: id));


class RecommendationProvider  {
  static Future<List<Series>> getRecommendationData ({required int id}) async{

    final data = await SeriesService.getSeriesRecommendations(id: id);
    return data.fold((l) => throw(l), (r) => r);

}

}