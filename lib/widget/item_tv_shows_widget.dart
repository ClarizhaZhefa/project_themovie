import 'package:flutter/material.dart';
import 'package:project/tvshows/model/tv_shows_detail_model.dart';
import 'package:project/tvshows/model/tv_shows_model.dart';
import 'package:project/widget/image_widget.dart';

class ItemTvShowsWidget extends Container {
  final TvShowsModel? tvShows;
  final TvShowsDetailModel? tvShowsDetail;
  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;

  ItemTvShowsWidget({
    required this.heightBackdrop,
    required this.widthBackdrop,
    required this.heightPoster,
    required this.widthPoster,
    this.radius = 12,
    this.tvShows,
    this.tvShowsDetail,
    this.onTap,
    super.key,
  });

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc:
                '${tvShowsDetail != null ? tvShowsDetail!.backdropPath : tvShows!.backdropPath}',
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc:
                      '${tvShowsDetail != null ? tvShowsDetail!.posterPath : tvShows!.posterPath}',
                  height: heightPoster,
                  width: widthPoster,
                  radius: 12,
                ),
                const SizedBox(height: 8),
                Text(
                  tvShowsDetail != null ? tvShowsDetail!.name : tvShows!.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    Text(
                      '${tvShowsDetail != null ? tvShowsDetail!.voteAverage : tvShows!.voteAverage} (${tvShowsDetail != null ? tvShowsDetail!.voteCount : tvShows!.voteCount})',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
}
