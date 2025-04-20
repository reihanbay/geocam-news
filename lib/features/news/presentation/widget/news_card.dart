import 'package:flutter/material.dart';
import 'package:geocam_news/core/constants/nav_route.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:provider/provider.dart';

import '../viewmodel/news_viewmodel.dart';

class NewsCard extends StatelessWidget {
  final NewsEntity model;
  const NewsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, NavRoute.detailNews.route,
            arguments: model);

        context.read<NewsViewModel>().getNews();
        context.read<NewsViewModel>().getNewsBookmarked();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: model.imageUrl != null
                  ? Image.network(
                      model.imageUrl!,
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.broken_image, size: 72),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    model.description??"Tap to see description",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
