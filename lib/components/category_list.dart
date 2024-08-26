import 'package:flutter/material.dart';
import '../data/models/restaurant_detail.dart';

class CategoryList extends StatelessWidget {
  final RestaurantDetail restaurants;
  const CategoryList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: restaurants.categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryList(context, restaurants.categories[index]);
        },
      ),
    );
  }
}

Widget _buildCategoryList(BuildContext context, Category category) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Chip(
      label: Text(category.name),
    ),
  );
}
