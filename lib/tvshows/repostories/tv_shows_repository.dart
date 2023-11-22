import 'package:dartz/dartz.dart';
import 'package:project/tvshows/model/tv_shows_detail_model.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/tvshows/model/tv_shows_video_model.dart';

abstract class TvShowsRepository {
  Future<Either<String, TvShowsResponseModel>> getDiscover({int page = 1});
  Future<Either<String, TvShowsResponseModel>> getTopRated({int page = 1});
  Future<Either<String, TvShowsResponseModel>> getAiringToday({int page = 1});
  Future<Either<String, TvShowsDetailModel>> getDetail({required int id});
  Future<Either<String, TvShowsVideosModel>> getVideos({required int id});
  Future<Either<String, TvShowsResponseModel>> search({required String query});
}           