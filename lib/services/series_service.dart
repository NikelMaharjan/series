

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:movie/api.dart';
import 'package:movie/exceptions/api_exception.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/models/cast_detail.dart';
import 'package:movie/models/cast_images.dart';
import 'package:movie/models/networks.dart';
import 'package:movie/models/seasons.dart';
import 'package:movie/models/seasons_details.dart';
import 'package:movie/models/videos.dart';
import '../models/series.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


class SeriesService{

  //by using dartz no need to throw error and catch in provider
  static  Future<Either<String, List<Series>>> getSeriesByCategory ({required String apiPath, required int page}) async{
    final dio = Dio();
    try{

      if(apiPath == Api.getPopularSeries){
        final response = await dio.get(apiPath,
            queryParameters: {
              'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
              'page': 1,
              'language': 'en-US'
            }
        );

        Hive.box<String>('data').put('series', jsonEncode(response.data!));   //this will save response in string. to display we need to decode


      }

      final response = await dio.get(apiPath,
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
            'page': page,
            'language': 'en-US'
          }
      );
      final data = (response.data['results'] as List).map((e) => Series.fromJson(e)).toList();
      return  right(data);

    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      if(errMessage == "No Internet." && apiPath == Api.getPopularSeries){
        final box = Hive.box<String>('data');
        if(box.isNotEmpty){
          final data = box.get('series');
          final cachedData = (jsonDecode(data!)['results'] as List).map((e) => Series.fromJson(e)).toList();
          return right(cachedData);

        }
      }
      return left(errMessage);
    }
  }


  static  Future<Either<String, List<Series>>> getSearchSeries ({required String apiPath, required int page, required String query}) async{
    final dio = Dio();
    try{
      final response = await dio.get(apiPath,
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
            'page': page,
            'language': 'en-US',
            'query': query
          }
      );
      final data = (response.data['results'] as List).map((e) => Series.fromJson(e)).toList();
      if((response.data['results'] as List).isEmpty){
        return left("Search using another Keyword");

      }

      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }

  static  Future<Either<String, List<Series>>> getSeriesByGenre ({required String apiPath, required int with_genres}) async{
    final dio = Dio();
    try{
      final response = await dio.get(apiPath,
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
            'with_genres': with_genres,
             'sort_by' : 'vote_count.desc',
          },

      );
      final data = (response.data['results'] as List).map((e) => Series.fromJson(e)).toList();


      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }

  static  Future<Either<String, List<Cast>>> getCastData ({required int id}) async{
    final dio = Dio();
    try{
      final response = await dio.get("https://api.themoviedb.org/3/tv/$id/credits",
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          }
      );
      final data = (response.data['cast'] as List).map((e) => Cast.fromJson(e)).toList();

      if(data.isEmpty){
        return left("No cast found");
      }


      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }


  static  Future<Either<String, CastDetail>> getCastDetails ({required int id}) async{
    final dio = Dio();
    try{
      final response = await dio.get('${Api.getCastDetails}/$id',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          }
      );
      final data = CastDetail.fromJson(response.data);


      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }



  static  Future<Either<String, List<SeasonDetails>>> getSeasonDetails ({required int seriesID, required seasonNumber}) async{
    final dio = Dio();
    try{
      final response = await dio.get('${Api.getSeasonDetails}/$seriesID/season/$seasonNumber',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          },
      );
      final data = (response.data['episodes'] as List).map((e) => SeasonDetails.fromJson(e)).toList();


      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }


  static  Future<Either<String, List<CastImages>>> getCastImages ({required int id}) async{
    final dio = Dio();
    try{

      final response = await dio.get('${Api.getCastImages}/$id/images',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          }
      );
      final data = (response.data['profiles'] as List).map((e) => CastImages.fromJson(e)).toList();


      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }


  static  Future<Either<String, Season>> getSeasonInfo ({required int id}) async{
    final dio = Dio();
    try{

      final response = await dio.get('${Api.getSeasonInfo}/$id',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
            'language': 'en-US',
          }
      );
      final data = Season.fromJson(response.data);
     // final data = (response.data['seasons'] as List).map((e) => Season.fromJson(e)).toList();

      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }


  static  Future<Either<String, NetworkInfo>> getNetworkInfo ({required int id}) async{
    final dio = Dio();
    try{

      final response = await dio.get('${Api.getNetworkInfo}/$id',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          }
      );
      final data = NetworkInfo.fromJson(response.data);

      return  right(data);
    } on DioError catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }






  static  Future<Either<String, List<Series>>> getSeriesRecommendations ({required int id}) async{
    final dio = Dio();
    try{

      final response = await dio.get('${Api.getSeriesRecommendations}/$id/recommendations',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
            'language': 'en-US',
          }
      );

      if((response.data['results'] as List).isEmpty){
        return left("No Recommendations");

      }

      final data = (response.data['results'] as List).map((e) => Series.fromJson(e)).toList();
      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }


  static  Future<Either<String, List<Video>>> getVideoId ({required int id}) async{
    final dio = Dio();
    try{
      final response = await dio.get('${Api.getVideosKey}/$id/videos',
          queryParameters: {
            'api_key': '2cf12587f0e8dfb033cd9ea15dc8f9bf',
          }
      );

      if((response.data['results'] as List).isEmpty){
        return left("No video");

      }
      final data = (response.data['results'] as List).map((e) => Video.fromJson(e)).toList();

      return  right(data);
    } on DioException catch (err){
      final errMessage = DioExceptions.getDioError(err);
      return left(errMessage);
    }


  }




}