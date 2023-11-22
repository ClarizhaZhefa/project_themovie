import 'package:dio/dio.dart';
import 'package:project/tvshows/model/tv_shows_detail_model.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:dartz/dartz.dart';
import 'package:project/tvshows/model/tv_shows_video_model.dart';
import 'package:project/tvshows/repostories/tv_shows_repository.dart';

class TvShowsRepositoryImpl implements TvShowsRepository {
  final Dio _dio;

  TvShowsRepositoryImpl(this._dio);

  @override
  Future<Either<String, TvShowsResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/tv',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get discover tv shows');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get discover tv shows');
    }
  }
  
  @override
  Future<Either<String, TvShowsResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/tv/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get top rated tv shows');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get top rated tv shows');
    }
  }
  
  @override
  Future<Either<String, TvShowsResponseModel>> getAiringToday({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/tv/airing_today',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get airing today tv shows');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get airing today tv shows');
    }
  }

  @override
  Future<Either<String, TvShowsDetailModel>> getDetail({required int id}) async {
   try {
      final result = await _dio.get(
        '/tv/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get tv shows detail');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get tv shows detail');
    }
  }

  @override
  Future<Either<String, TvShowsVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/tv/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsVideosModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get tv videos');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get tv videos');
    }
  }
  
  @override
  Future<Either<String, TvShowsResponseModel>> search({required String query}) async {
    try {
      final result = await _dio.get(
        '/search/tv',
        queryParameters: {"query": query},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = TvShowsResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error search tv');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on search tv');
    }
  }
  
}