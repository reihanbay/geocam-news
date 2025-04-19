import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocam_news/core/constants/nav_route.dart';
import 'package:geocam_news/core/services/api_client_services.dart';
import 'package:geocam_news/features/geocam/presentation/homecam_screen.dart';
import 'package:geocam_news/features/main_screen.dart';
import 'package:geocam_news/features/news/data/datasources/news_api_services.dart';
import 'package:geocam_news/features/news/data/repositories/news_repository_impl.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';
import 'package:geocam_news/features/news/domain/usecase/news_usecase.dart';
import 'package:geocam_news/features/news/presentation/detail_new_screen.dart';
import 'package:geocam_news/features/news/presentation/news_screen.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:geocam_news/shared/bottomnav_provider.dart';
import 'package:provider/provider.dart';

void main() {


  //News
  ApiClient client = ApiClient();
  NewsApiServices newsApiServices = NewsApiServices(client);
  NewsRepository newsRepo = NewsRepositoryImpl(newsApiServices);
  NewsUsecase newsUsecase = NewsUsecase(newsRepo);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NewsViewModel(newsUsecase)),
    ChangeNotifierProvider(create: (context) => BottomNavProvider())
  ],
  child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geocam News',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0B86E7), brightness: Brightness.light),
        useMaterial3: true
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0B86E7), brightness: Brightness.dark),
        useMaterial3: true
      ),
      initialRoute: NavRoute.main.route,
      routes: {
        NavRoute.main.route : (context) => const MainScreen(),
        NavRoute.homeCam.route: (context) => const HomecamScreen(),
        NavRoute.news.route: (context) => const NewsScreen(),
        NavRoute.detailNews.route: (context) => NewsDetailScreen(
          model: ModalRoute.of(context)?.settings.arguments as NewsEntity
        )
      },
    );
  }
}
