

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/models/series_state.dart';
import '../services/series_service.dart';


final seriesProvider = StateNotifierProvider<SeriesProvider, SeriesState>((ref) => SeriesProvider(SeriesState.initState()));


class SeriesProvider extends StateNotifier<SeriesState>{
  SeriesProvider(super.state){
    getSeriesData();   //this method will call automatically when this provider is watched
  }





  Future<void> getSeriesData() async{
    state = state.copyWith(isLoad: state.isloadMore ? false : true);
    final data = await SeriesService. getSeriesByCategory(apiPath: state.apiPath, page: state.page);
    data.fold((l) {
      state = state.copyWith(errText: l, isLoad: false);

    }, (r) {

      state = state.copyWith(errText: '', isLoad: false, series: [...state.series, ...r]);

    });


  }


  void changeCategory({required String apiPath}){
    state = state.copyWith(apiPath: apiPath, series: [], isloadMore: false, page: 1);
    getSeriesData();

  }



  void refresh(){
    state = state.copyWith(page: 1);
    getSeriesData();

  }


  void loadMore(){
    state = state.copyWith(page: state.page +1, isloadMore: true );
    getSeriesData();

  }



}


















