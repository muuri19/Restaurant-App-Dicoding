import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_seacrh_provider.dart';
import '../widgets/card_restaurant.dart';

import '../data/enum/result_state.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search';
  const RestaurantSearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text('Pencarian'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              cursorColor: Colors.white,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                hintText: 'Cari berdasarkan nama restoran',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onSubmitted: (query) {
                if (query != '') {
                  Provider.of<RestaurantSearchProvider>(
                    context,
                    listen: false,
                  ).searchRestaurant(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
                builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icon-search.png', height: 150),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Finding restaurant for you,\nPlease Wait',
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else if (state.state == ResultState.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  },
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
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
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(
          child: LoadingAnimationWidget.halfTriangleDot(
        color: Colors.blue,
        size: 30,
      ));
}
