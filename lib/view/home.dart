import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:tv_shows/controller/movie_controller.dart';
import 'package:tv_shows/view/movie_detail.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final moviesC = Get.put(MovieController());
  //Searchbar
  Widget searchbar(width) {
    return Container(
      width: width,
      height: 40,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff888888),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.search,
            size: 20,
            color: Colors.white,
          ),
          Expanded(
            child: TextFormField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                  border: InputBorder.none,
                ),
                onChanged: (value) => moviesC.search(value)),
          ),
        ],
      ),
    );
  }

  //movies view
  Widget movies(width) {
    var status = ['Running', 'Ended'];
    return Expanded(
      child: ListView.builder(
          itemCount: status.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    status[index].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
                Container(
                  width: width,
                  height: width / 1.5,
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: moviesC.results.length,
                      itemBuilder: ((context, x) {
                        if (moviesC.results[x]['status'] ==
                            status[index].toString()) {
                          return Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(MovieDetail(
                                      id: moviesC.results[x]['id'],
                                      name: moviesC.results[x]['name'],
                                      image: moviesC.results[x]['image']
                                          ['original'],
                                      summary: moviesC.results[x]['summary'],
                                      rating: moviesC.results[x]['rating']
                                              ['average']
                                          .toString(),
                                      genre: moviesC.results[x]['genres']));
                                },
                                child: Container(
                                  width: width / 3.5,
                                  height: width / 1.5 - 100,
                                  color: Colors.grey,
                                  child: Image.network(
                                    moviesC.results[x]['image']['original'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width / 3.5 - 25,
                                    height: 40,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      moviesC.results[x]['name'],
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                    child: IconButton(
                                        onPressed: () {
                                          moviesC.addWishlist(x);
                                        },
                                        icon: const Icon(Icons.favorite),
                                        color: moviesC.favoriteColor[x]),
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      })),
                ),
              ],
            );
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<MovieController>(
          builder: ((controller) => controller.isLoading
              ? Container(
                  color: const Color(0xff0d0d0d),
                  child: const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white))))
              : Container(
                  color: const Color(0xff0d0d0d),
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [searchbar(width), movies(width)]),
                ))),
    ));
  }
}
