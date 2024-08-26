import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant.dart';
import '../provider/restaurant_detail_provider.dart';
import '../widgets/detail_restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail-restaurant';

  final Restaurant restaurant;
  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
          apiService: ApiService(http.Client()), restaurantId: restaurant.id),
      child: DetailRestaurant(restaurant: restaurant),
    );
  }
}
