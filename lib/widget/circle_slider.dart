import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

class CirclesSlider extends StatelessWidget {
  final List<Movie> movies;

  // const CirclesSlider({Key key, this.movies}) : super(key: key);
  CirclesSlider({this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('미리보기'),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: makeCircleImages(movies),
          ),
        ),
      ]),
    );
  }

  makeCircleImages(List<Movie> movies) {
    List<Widget> results = [];
    for (var i = 0; i < movies.length; i++) {
      results.add(InkWell(
        onTap: () {},
        child: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/' + movies[i].poster),
              radius: 48,
            ),
          ),
        ),
      ));
    }
    return results;
  }

  // makeCircleImages(movies) {}
}

// makeCircleImages(List<Movie> movies) {
// }