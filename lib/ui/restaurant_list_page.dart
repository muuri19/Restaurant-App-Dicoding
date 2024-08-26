import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../data/enum/result_state.dart';
import '../provider/restaurant_provider.dart';
import '../ui/restaurant_search_page.dart';
import '../widgets/card_restaurant.dart';

import '../widgets/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant-list';
  const RestaurantListPage({super.key});

  Widget _buildList() {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return _buildLoading();
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            });
      } else if (state.state == ResultState.error) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon-no-internet.png',
                height: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(state.message)
            ],
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App API'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
            child: Image.asset(
              'assets/icon-search.png',
              width: 25,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App API'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  Widget _buildLoading() => Center(
          child: LoadingAnimationWidget.halfTriangleDot(
        color: Colors.blue,
        size: 50,
      ));

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
