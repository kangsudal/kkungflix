import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;

  // const BoxSlider({Key key, this.movies}) : super(key: key);
  BoxSlider({this.movies});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("지금 뜨는 콘텐츠"),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: makeBoxImages(movies, context),
          ),
        ),
      ]),
    );
  }

  List<Widget> makeBoxImages(List<Movie> movies, BuildContext context) {
    List<Widget> results = [];
    for (var i = 0; i < movies.length; i++) {
      results.add(
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<Null>(
                fullscreenDialog: true,
                builder: (BuildContext context) {
                  return DetailScreen(
                    movie: movies[i],
                  );
                }));
          },
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.network(movies[i].poster),
            ),
          ),
        ),
      );
    }
    return results;
  }
}
