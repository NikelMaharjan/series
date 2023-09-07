
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/seasons.dart';
import 'package:movie/services/series_service.dart';



final seasonProvider = FutureProvider.autoDispose.family((ref, int id) => SeasonProvider.getSeasonData(id));



class SeasonProvider{

  static  Future<Season> getSeasonData(int id) async {
    final data = await SeriesService.getSeasonInfo(id: id);
    return data.fold((l) => throw(l), (r) => r);
  }

}