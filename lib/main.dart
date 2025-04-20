import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocam_news/core/constants/nav_route.dart';
import 'package:geocam_news/core/services/location_service.dart';
import 'package:geocam_news/features/geocam/data/datasources/geocam_local_datasource.dart';
import 'package:geocam_news/features/geocam/data/repositories/geocam_repository_impl.dart';
import 'package:geocam_news/features/geocam/data/repositories/location_repository_impl.dart';
import 'package:geocam_news/features/geocam/domain/usecase/get_location_stream.dart';
import 'package:geocam_news/features/geocam/domain/usecase/load_location_usecase.dart';
import 'package:geocam_news/features/geocam/domain/usecase/load_photo_usecase.dart';
import 'package:geocam_news/features/geocam/domain/usecase/reset_data_usecase.dart';
import 'package:geocam_news/features/geocam/domain/usecase/save_photo_and_location_usecase.dart';
import 'package:geocam_news/core/services/api_client_services.dart';
import 'package:geocam_news/features/geocam/presentation/homecam_screen.dart';
import 'package:geocam_news/features/geocam/presentation/viewmodel/geocam_viewmodel.dart';
import 'package:geocam_news/features/main_screen.dart';
import 'package:geocam_news/features/news/data/datasources/news_local_datasources.dart';
import 'package:geocam_news/features/news/data/datasources/news_remote_datasources.dart';
import 'package:geocam_news/features/news/data/repositories/news_repository_impl.dart';
import 'package:geocam_news/features/news/domain/entity/news_entity.dart';
import 'package:geocam_news/features/news/domain/repositories/news_repository.dart';
import 'package:geocam_news/features/news/domain/usecase/local_news_usecase.dart';
import 'package:geocam_news/features/news/domain/usecase/news_usecase.dart';
import 'package:geocam_news/features/news/presentation/detail_new_screen.dart';
import 'package:geocam_news/features/news/presentation/news_screen.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/detail_news_viewmodel.dart';
import 'package:geocam_news/features/news/presentation/viewmodel/news_viewmodel.dart';
import 'package:geocam_news/shared/bottomnav_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final locationService = LocationService();
  final locationRepo = LocationRepositoryImpl(locationService);
  
  final getLocationStream = GetLocationStream(locationRepo); //usecase Stream
  
  final preferences = await SharedPreferences.getInstance();
  final geocamDataSource = GeocamLocalDatasource(preferences);
  final geocamRepo = GeocamRepositoryImpl(geocamDataSource);
  final savePhotoLocation = SavePhotoAndLocationUsecase(geocamRepo);
  final loadPhoto = LoadPhotoUsecase(geocamRepo);
  final loadLocation = LoadLocationUsecase(geocamRepo);
  final resetData = ResetDataUsecase(geocamRepo);
  //News
  ApiClient client = ApiClient();
  NewsLocalDatasources newsLocalDatasource = NewsLocalDatasources();
  NewsRemoteDatasources newsApiServices = NewsRemoteDatasources(client);
  NewsRepository newsRepo = NewsRepositoryImpl(newsApiServices, newsLocalDatasource);
  NewsUsecase newsUsecase = NewsUsecase(newsRepo);
  LocalNewsUsecase newsLocalUsecase = LocalNewsUsecase(newsRepo);
  
  runApp(MultiProvider(providers: [
    Provider(create: (context) => LocationService()),
    ChangeNotifierProvider(create: (context) => GeocamViewmodel(getLocationStream, savePhotoLocation, loadPhoto, loadLocation, resetData)),
    ChangeNotifierProvider(create: (context) => NewsViewModel(newsUsecase, newsLocalUsecase)),
    ChangeNotifierProvider(create: (context) => DetailNewsViewmodel(newsLocalUsecase)),
    ChangeNotifierProvider(create: (context) => BottomNavProvider())
  ],
  child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
