import 'package:flutter/material.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'widget/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    super.initState();
    fetch(context);
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "GeoCam News",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0070F3), // Blue title
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.newspaper_rounded),
            ),
            Tab(
              icon: Icon(Icons.bookmark),
            ),
          ]),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        body: TabBarView(
          children: [
            SafeArea(
              child: TabListNews(),
            ),
            SafeArea(
              child: TabListNews(isLocal: true),
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> fetch(BuildContext context) async {
    context.read<NewsViewModel>().getNews();
    context.read<NewsViewModel>().getNewsBookmarked();
}

class TabListNews extends StatelessWidget {
  final bool isLocal;
  const TabListNews({
    super.key,
    this.isLocal = false
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<NewsViewModel>(
          builder: (context, value, child) {
            return Expanded(
              child: value.isLoadingState ? 
              Center(
                child: CircularProgressIndicator(backgroundColor: Theme.of(context).colorScheme.surfaceContainer, color: Theme.of(context).colorScheme.primary),
              ) 
              :
              LiquidPullToRefresh(
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.surface,
                springAnimationDurationInMilliseconds: 500,
                onRefresh:  () => fetch(context) ,
                child: ListView.builder(
                  itemCount: isLocal ? value.listNewsLocal.length : value.listNews.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: NewsCard(
                        model: isLocal ? value.listNewsLocal[index] : value.listNews[index],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}


