import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/injector.dart';
import 'package:project/movie/providers/movie_get_detail_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<MovieGetDetailProvider>(
              builder:(_, provider, __) {
                // if (provider.movie != null) {
                //   log(provider.movie.toString()as num);
                // }
                return SliverAppBar(
                title: 
                  Text(provider.movie != null ? provider.movie!.title:''
                  ),
              );
            },
            ),
          ],
        ),
      ),
      );
  }
}