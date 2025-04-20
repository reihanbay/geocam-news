import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocam_news/features/geocam/presentation/homecam_screen.dart';
import 'package:geocam_news/features/news/presentation/news_screen.dart';
import 'package:geocam_news/shared/bottomnav_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 74,
        backgroundColor: Theme.of(context).colorScheme.surface,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          context.read<BottomNavProvider>().setIndexBottomNav = value;
        },
        selectedIndex: context.watch<BottomNavProvider>().indexBottomNav,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset("assets/location.svg"), 
            selectedIcon: SvgPicture.asset('assets/location_on.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: "Home"),
          NavigationDestination(
            icon: SvgPicture.asset("assets/news.svg"), 
            selectedIcon: SvgPicture.asset('assets/news_on.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
            label: "News")
      ]),
      body: Consumer<BottomNavProvider>(builder: (context, value, child) {
        return <Widget>[
          const HomecamScreen(),
          const NewsScreen()
        ][value.indexBottomNav];
      }),
    );
  }
}