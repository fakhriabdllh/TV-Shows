import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_shows/controller/movie_controller.dart';
import 'package:tv_shows/view/movie_detail.dart';

class WatchList extends StatelessWidget {
  WatchList({Key? key}) : super(key: key);
  final _moviesC = Get.put(MovieController());

  Widget wishlistText() {
    return const SizedBox(
      child: Text(
        'WISHLIST',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget wishlistView(width) {
    return (_moviesC.wishlist.isEmpty)
        ? const Expanded(
            child: Center(
                child: Text(
              'NO SHOWS YET',
              style: TextStyle(color: Colors.grey, fontSize: 30),
            )),
          )
        : Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1 / 2),
                itemCount: _moviesC.wishlist.length,
                itemBuilder: (BuildContext context, index) {
                  return SizedBox(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(MovieDetail(
                                id: _moviesC.wishlist[index]['id'],
                                name: _moviesC.wishlist[index]['name'],
                                image: _moviesC.wishlist[index]['image']
                                    ['original'],
                                summary: _moviesC.wishlist[index]['summary'],
                                rating: _moviesC.wishlist[index]['rating']
                                        ['average']
                                    .toString(),
                                genre: _moviesC.wishlist[index]['genres']));
                          },
                          child: Container(
                            width: width / 3.5,
                            height: width / 1.5 - 120,
                            color: Colors.grey,
                            child: Image.network(
                              _moviesC.wishlist[index]['image']['original'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width / 3.5 - 30,
                              height: 40,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _moviesC.wishlist[index]['name'],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                  onPressed: () {
                                    _moviesC.removeWishlist(index);
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xff0d0d0d),
      child: GetBuilder<MovieController>(
          builder: ((e) => Column(
                children: [
                  wishlistText(),
                  const SizedBox(
                    height: 10,
                  ),
                  wishlistView(width)
                ],
              ))),
    ));
  }
}
