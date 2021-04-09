import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/widget/carousel_slider.dart';
import 'package:netflix_clone/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title':'나의 가족 나의 도시',
      'keyword': '가족/코미디/드라마',
      'poster': 'poster_myfamily.jpg',
      'like':false,
    }),
    Movie.fromMap({
      'title':'사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'poster_love.jpg',
      'like':false,
    }),
    Movie.fromMap({
      'title':'뷰티풀마인드',
      'keyword': '드라마/로맨스',
      'poster': 'a-beautiful-mind.jpg',
      'like':false,
    }),
    Movie.fromMap({
      'title':'굿윌헌팅',
      'keyword': '드라마/로맨스',
      'poster': 'good-will-hunting.png',
      'like':false,
    }),
    Movie.fromMap({
      'title':'Life as a house',
      'keyword': '드라마/패밀리',
      'poster': 'Life-as-a-house.jpg',
      'like':false,
    }),
    Movie.fromMap({
      'title':'메멘토',
      'keyword': '스릴러/미스터리',
      'poster': 'memento.jpg',
      'like':false,
    }),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            CarouselImage(movies:movies),
            TopBar(),
          ],
        ),
        CirclesSlider(
          movies: movies,
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo-netflix.png',
            fit: BoxFit.contain,
            height: 45,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
