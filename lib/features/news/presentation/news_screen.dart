import 'package:flutter/material.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';
import 'widget/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<NewsViewModel>().getNews();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "GeoCam News",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0070F3), // Blue title
                ),
              ),
              const SizedBox(height: 16),
              Consumer<NewsViewModel>(
                builder: (context, value, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.listNews.length-1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: NewsCard(
                            model: value.listNews[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
