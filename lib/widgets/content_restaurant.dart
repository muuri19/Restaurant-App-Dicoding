import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import '../data/models/restaurant_detail.dart';

import '../data/enum/result_state.dart';

class ContentRestaurant extends StatelessWidget {
  final RestaurantDetail restaurantDetailResult;
  final RestaurantDetailProvider provider;

  const ContentRestaurant(
      {super.key,
      required this.restaurantDetailResult,
      required this.provider});

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://restaurant-api.dicoding.dev/images/large/';
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return _buildLoading();
        } else if (state.state == ResultState.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(restaurantDetailResult.name),
            ),
            backgroundColor: Colors.blueGrey,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "$imageUrl${restaurantDetailResult.pictureId}"))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantDetailResult.name,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                restaurantDetailResult.city,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                restaurantDetailResult.rating.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            restaurantDetailResult.description,
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            'Menu Food',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/no-data.png', height: 170),
                  const Text(
                    'Restaurant Not Found!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/no-internet.png', height: 170),
                  const Text(
                    'Sorry, an error occurred in the connection!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildLoading() => Center(
          child: LoadingAnimationWidget.halfTriangleDot(
        color: Colors.blue,
        size: 30,
      ));
}
