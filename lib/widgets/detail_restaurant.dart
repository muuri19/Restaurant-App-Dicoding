import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/category_list.dart';
import 'package:restaurant_app/components/drink_list.dart';
import 'package:restaurant_app/components/food_list.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/components/bottom_sheet_review.dart';
import 'package:restaurant_app/widgets/button_favorite.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const DetailRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return _buildLoading();
      } else if (state.state == ResultState.hasData) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded)),
            title: Text(restaurant.name),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Added
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          restaurant.name,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon-location.png',
                            width: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon-rating.png',
                            width: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(restaurant.rating.toString()),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Category : '),
                  CategoryList(restaurants: state.result.restaurant),
                  const Text('Food :'),
                  FoodList(restaurants: state.result.restaurant),
                  const Text('Drink :'),
                  DrinkList(restaurants: state.result.restaurant),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ),
                          ),
                          builder: (context) {
                            return BottomSheetReview(
                              restaurants: state.result.restaurant,
                              provider: state,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text(
                        'Lihat Review',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  ButtonFavorite(
                    restaurant: state.result.restaurant,
                  )
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
                ),
              ],
            ),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon-no-internet.png', height: 170),
              const Text(
                'Sorry, an error occurred in the connection!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      } else {
        return const Center(child: Text(''));
      }
    });
  }

  Widget _buildLoading() => Center(
          child: LoadingAnimationWidget.halfTriangleDot(
        color: Colors.blue,
        size: 50,
      ));
}
