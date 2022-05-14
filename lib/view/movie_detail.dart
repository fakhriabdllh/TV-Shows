import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
    required this.summary,
    required this.rating,
    required this.genre,
  }) : super(key: key);

  final int id;
  final String name, image, summary, rating;
  final List genre;
  //nama,genre,poster,sinposis,rating,daftar aktor aktris,
  //daftar episode

  Widget imageWidget(width) {
    return Container(
      width: width / 2.3,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
        )
      ]),
      child: Image.network(
        image,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget detailWidget(width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width - width / 2.3 - 20,
      child: Column(
        children: [
          //Name
          Container(
            alignment: Alignment.center,
            child: Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //GENRE
              Row(children: [
                Container(
                    width: (width - width / 2.3 - 20) / 4,
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Genre',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        genre.toString(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      )),
                ),
              ]),
              //RATING
              Row(children: [
                Container(
                    width: (width - width / 2.3 - 20) / 4,
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Rating',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      rating,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )),
              ]),
            ],
          )
        ],
      ),
    );
  }

  Widget summaryWidget() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          summary,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0d0d0d),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xff0d0d0d),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [imageWidget(width), detailWidget(width)],
                ),
              ),
              summaryWidget()
            ],
          ),
        ),
      ),
    );
  }
}
