

import 'package:movie/api.dart';
import 'package:movie/models/series.dart';


class SeriesState{

  final String errText;
  final List<Series> series;
  final bool isLoad;
  final String apiPath;
  final int page;
  final bool isloadMore;


  SeriesState({required this.errText, required this.series, required this.isloadMore, required this.isLoad, required this.apiPath, required this.page});


  SeriesState.initState() : errText = '', series = [], apiPath = Api.getPopularSeries, page =1, isloadMore = false, isLoad = false;
 // SeriesState.initState1() : errText = '', series = [], apiPath = Api.getTopRatedSeries, page =1, isloadMore = false, isLoad = false;
 // SeriesState.initState2() : errText = '', series = [], apiPath = Api.getAiringSeries, page =1, isloadMore = false, isLoad = false;


  SeriesState copyWith({String? errText, List<Series>? series, bool? isLoad, String? apiPath, int? page, bool? isloadMore}){
    return SeriesState(
        errText: errText ?? this.errText,
        series: series ?? this.series,
        isLoad: isLoad ?? this.isLoad,
        isloadMore: isloadMore ?? this.isloadMore,
        apiPath: apiPath ?? this.apiPath,
        page: page ?? this.page
    );
  }


}