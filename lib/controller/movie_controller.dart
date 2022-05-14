// ignore_for_file: invalid_use_of_protected_member, duplicate_ignore

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  var movies = [];
  var results = [];
  var isLoading = true;
  var wishlist = [];
  var favoriteColor = [];

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows'));
    if (response.statusCode == 200) {
      movies = json.decode(response.body);
      for (int i = 0; i < movies.length; i++) {
        favoriteColor.add(Colors.grey);
      }
      isLoading = false;
      results = movies;
      update();
    } else {
      Get.snackbar('Error Loading Data',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
      update();
    }
  }

  addWishlist(i) {
    wishlist.add(results[i]);
    favoriteColor[i] = Colors.pink;
    update();
  }

  removeWishlist(i) {
    wishlist.removeAt(i);
    update();
  }

  search(input) {
    if (input.isEmpty) {
      results = movies;
      update();
    } else {
      results = movies
          .where((e) => e['name']
              .toString()
              .toLowerCase()
              .contains(input.toString().toLowerCase()))
          .toList();
      update();
    }
  }
}
