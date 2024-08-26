import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui/restaurant_favorite_page.dart';
import '../ui/restaurant_list_page.dart';
import '../ui/setting_page.dart';
import '../common/style.dart';
import '../widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const RestaurantFavoritePage(),
    const SettingPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.restaurant_menu_outlined,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.restaurant_menu_outlined,
          color: Colors.blue,
        ),
        label: 'Restaurant',
        backgroundColor: Colors.white),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.favorite,
          color: Colors.blue,
        ),
        label: 'Favorite',
        backgroundColor: Colors.white),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.settings,
          color: Colors.blue,
        ),
        label: 'Setting',
        backgroundColor: Colors.white),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
