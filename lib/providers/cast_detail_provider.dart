



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/models/cast_detail.dart';
import 'package:movie/services/series_service.dart';


final castDetailProvider = FutureProviderFamily((ref, int id) => CastDetailProvider.getCastDetail(id: id));

class CastDetailProvider {


  static Future<CastDetail> getCastDetail ({required int id}) async {

    final data = await SeriesService.getCastDetails(id: id);
    return data.fold((l) => throw(l), (r) => r);

  }


}