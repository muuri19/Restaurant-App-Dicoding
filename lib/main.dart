import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../data/db/database_helper.dart';
import '../data/models/restaurant.dart';
import '../data/preferences/preferences_helper.dart';
import '../provider/database_provider.dart';
import '../provider/preferences_provider.dart';
import '../provider/restaurant_seacrh_provider.dart';
import '../provider/scheduling_provider.dart';
import '../ui/home_page.dart';
import '../ui/restaurant_detail_page.dart';
import '../ui/restaurant_favorite_page.dart';
import '../ui/restaurant_list_page.dart';
import '../ui/restaurant_search_page.dart';
import 'package:http/http.dart' as http;
import '../utils/background_services.dart';
import '../utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api/api_service.dart';
import 'provider/restaurant_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(FlutterLocalNotificationsPlugin());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) =>
              RestaurantProvider(apiService: ApiService(http.Client())),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) =>
              RestaurantSearchProvider(apiService: ApiService(http.Client())),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'REST API RESTAURANT',
        theme: ThemeData.dark(useMaterial3: true),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantFavoritePage.routeName: (context) =>
              const RestaurantFavoritePage(),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant:
                    ModalRoute.of(context)!.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}
