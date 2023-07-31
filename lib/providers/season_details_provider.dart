







import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/models/cast_detail.dart';
import 'package:movie/models/seasons_details.dart';
import 'package:movie/services/series_service.dart';


class Test extends Equatable {
  final int seriesId;
  final int seasonNumber;

  Test({required this.seriesId, required this.seasonNumber});

  @override
  List<Object?> get props => [seriesId, seasonNumber];




}


//final seasonDetailProvider =  FutureProvider.family((ref, int seriesId, int seasonNumber) => SeasonDetailProvider.getSeasonDetails(seriesID: seriesID, seasonNumber: seasonNumber));


final seasonDetailProvider =  FutureProvider.family.autoDispose((ref, Test test) => SeasonDetailProvider.getSeasonDetails(seriesID: test.seriesId, seasonNumber: test.seasonNumber));

class SeasonDetailProvider {


  static Future<List<SeasonDetails>> getSeasonDetails ({required int seriesID, required seasonNumber}) async {

    final data = await SeriesService.getSeasonDetails(seriesID: seriesID, seasonNumber: seasonNumber);
    return data.fold((l) => throw(l), (r) => r);

  }


}