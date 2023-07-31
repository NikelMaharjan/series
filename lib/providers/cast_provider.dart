



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/services/series_service.dart';


final castProvider = FutureProviderFamily((ref, int id) => CastProvider.getCastList(id: id));

class CastProvider {


  static Future<List<Cast>> getCastList ({required int id}) async {

    final data = await SeriesService.getCastData(id: id);
    return data.fold((l) => throw(l), (r) => r);

  }


}