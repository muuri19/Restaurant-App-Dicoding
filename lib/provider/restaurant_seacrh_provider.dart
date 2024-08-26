import 'package:flutter/material.dart';
import '../data/models/search_restaurant.dart';
import '../data/api/api_service.dart';
import '../data/enum/result_state.dart';


class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late SearchRestaurantResult _searchRestaurantResult;
  SearchRestaurantResult get result => _searchRestaurantResult;

  late ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  void setQuery(String query) {
    searchRestaurant(query);
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantSearch = await apiService.getSeacrhRestaurant(query);
      if (restaurantSearch.founded == 0 &&
          restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Pencarian Tidak Ditemukan';
      } else {
        _state = ResultState.hasData;
        _searchRestaurantResult = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
    }
    notifyListeners();
  }
}
