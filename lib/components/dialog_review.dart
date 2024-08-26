import 'package:flutter/material.dart';
import '../provider/restaurant_detail_provider.dart';

import '../data/enum/result_state.dart';

class DialogReview extends StatelessWidget {
  final RestaurantDetailProvider provider;
  final String restaurantId;
  DialogReview({super.key, required this.restaurantId, required this.provider});

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(16),
      title: const Text('Add Review'),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  cursorColor: Colors.white,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  cursorColor: Colors.white,
                  controller: _reviewController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Review tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              FormState? form = _formKey.currentState;

              if (form != null) {
                if (form.validate()) {
                  provider
                      .postReview(
                          id: restaurantId,
                          name: _nameController.text,
                          review: _reviewController.text)
                      .then((value) {
                    if (value == ResultState.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Successfully added a review'),
                              Image.asset(
                                'assets/success.png',
                                width: 25,
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: const Text(
              'Tambah',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
