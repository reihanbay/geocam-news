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
import 'package:geocam_news/features/geocam/presentation/homecam_screen.dart';
import 'package:geocam_news/features/geocam/presentation/viewmodel/geocam_viewmodel.dart';
import 'package:geocam_news/features/main_screen.dart';
import 'package:geocam_news/features/news/presentation/news_screen.dart';
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
  runApp(MultiProvider(providers: [
    Provider(create: (context) => LocationService()),
    ChangeNotifierProvider(create: (context) => GeocamViewmodel(getLocationStream, savePhotoLocation, loadPhoto, loadLocation, resetData)),
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
        NavRoute.news.route: (context) => const NewsScreen()
      },
    );
  }
}
