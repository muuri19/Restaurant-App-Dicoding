import 'package:flutter/material.dart';

import '../data/models/restaurant_detail.dart';

class FoodList extends StatelessWidget {
  final RestaurantDetail restaurants;

  const FoodList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: restaurants.menus.foods.length,
        itemBuilder: (context, index) {
          return _buildFoodList(context, restaurants.menus.foods[index]);
        },
      ),
    );
  }
}

Widget _buildFoodList(BuildContext context, Category food) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Chip(
      label: Text(food.name),
    ),
  );
}
