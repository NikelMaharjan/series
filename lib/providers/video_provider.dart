

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/videos.dart';
import 'package:movie/services/series_service.dart';

final videoProvider = FutureProvider.autoDispose.family((ref, int id) => VideoProvider.getVideoId(id: id));


class VideoProvider{

  static  Future<List<Video>> getVideoId({required int id}) async{
    final response = await SeriesService.getVideoId(id: id);
    return response.fold((l) => throw l , (r) => r);
  }


}