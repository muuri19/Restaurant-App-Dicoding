import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import '../data/models/restaurant.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    '$imageUrl/${restaurant.pictureId}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(restaurant.name),
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
