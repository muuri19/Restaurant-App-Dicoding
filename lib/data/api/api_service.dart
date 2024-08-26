import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/search_restaurant.dart';

import '../models/post_review.dart';
import '../models/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  ApiService(http.Client client);


  Future<RestaurantResult> getListRestaurant() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if(response.statusCode == 200){
      final result = RestaurantResult.fromJson(jsonDecode(response.body));
      DMethod.log('$result');
      return result;
    }else{
      throw Exception('Error pada fungsi getListRestaurant');
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if(response.statusCode == 200){
      final result = RestaurantDetailResult.fromJson(jsonDecode(response.body));
      DMethod.log('$result');
      return result;
    }else{
      throw Exception('Error pada fungsi getListRestaurant');
    }
  }

  Future<SearchRestaurantResult> getSeacrhRestaurant(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if(response.statusCode == 200){
      final result = SearchRestaurantResult.fromJson(jsonDecode(response.body));
      DMethod.log('$result');
      return result;
    }else{
      throw Exception('Error pada fungsi getSeacrhRestaurant');
    }
  }

  Future<PostReviewResult> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return PostReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed post data');
    }
  }
}