
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/services/series_service.dart';

import '../models/networks.dart';



final networkProvider = FutureProvider.autoDispose.family((ref, int id) => NetworkProvider.getNetworkInfo(id: id));

class NetworkProvider {

  static Future<NetworkInfo> getNetworkInfo ({required int id}) async{

    final data = await SeriesService.getNetworkInfo(id: id);
    return data.fold((l) => throw(l), (r) => r);

  }


}