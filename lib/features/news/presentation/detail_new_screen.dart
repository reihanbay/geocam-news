import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/detail_news_viewmodel.dart';
import 'package:geocam_news/shared/utils/datetime.dart';
import 'package:provider/provider.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsEntity model;
  const NewsDetailScreen({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    final vm =context.read<DetailNewsViewmodel>();
    vm.getNewsByTitle(model.title);
    vm.isBookmarked(model.title);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Consumer<DetailNewsViewmodel>(
          builder: (context, value, child) {
            return Column(
              children: [
                Stack(
                  children: [
                    if (model.imageUrl != null)
                      Image.network(
                        model.imageUrl!,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    else
                      SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Icon(Icons.broken_image, size: 250)),
                    Positioned(
                        top: 16,
                        left: 16,
                        child: FloatingActionButton(
                          heroTag: "back",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.white,
                          mini: true,
                          child: Icon(
                            Icons.navigate_before_sharp,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Row(
                        children: [
                          FloatingActionButton(
                            heroTag: "bookmark",
                            onPressed: () {
                              value.updateBookmark(model.title, !value.isBookmark);
                              value.isBookmarked(value.news?.title??model.title);
                            },
                            backgroundColor: Colors.white,
                            mini: true,
                            child: value.isBookmark
                                ? SvgPicture.asset(
                                    "assets/bookmark_saved.svg",
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.onPrimary,
                                        BlendMode.srcIn),
                                  )
                                : SvgPicture.asset("assets/bookmark.svg"),
                          ),
                          const SizedBox(width: 12),
                          FloatingActionButton(
                            heroTag: "web",
                            onPressed: () {},
                            backgroundColor: Colors.white,
                            mini: true,
                            child: Icon(Icons.web,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formattedDate(model.publishedAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            model.content ?? "Deskripsi Tidak Tersedia",
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          Text.rich(
                            TextSpan(
                              text: 'Author - ',
                              style: TextStyle(fontSize: 14),
                              children: [
                                TextSpan(
                                  text: model.author ?? "Tidak tersedia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
