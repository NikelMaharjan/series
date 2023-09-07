
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/api.dart';
import 'package:movie/models/series_state.dart';
import 'package:movie/services/series_service.dart';



final searchProvider = StateNotifierProvider<SearchProvider, SeriesState>((ref) => SearchProvider(SeriesState.initState()));

class SearchProvider extends StateNotifier<SeriesState>{
  SearchProvider(super.state);


  Future<void> getSeriesData({required String searchText}) async {

    state = state.copyWith(isLoad: true);

    final data = await SeriesService.getSearchSeries(apiPath: Api.getSearchSeries, page: state.page, query: searchText);
    data.fold((l) {
      state = state.copyWith(isLoad: false, errText: l);

    }, (r) {
      state = state.copyWith(isLoad: false, series: r, errText: '');
    });


  }


}