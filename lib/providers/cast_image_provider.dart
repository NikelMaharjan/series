





import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/models/cast_detail.dart';
import 'package:movie/models/cast_images.dart';
import 'package:movie/services/series_service.dart';


final castImageProvider = FutureProviderFamily((ref, int id) => CastImageProvider.getCastImages(id: id));

class CastImageProvider {


  static Future<List<CastImages>> getCastImages ({required int id}) async {

    final data = await SeriesService.getCastImages(id: id);
    return data.fold((l) => throw(l), (r) => r);

  }


}