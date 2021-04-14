import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({this.movies}); //생성자.이 위젯에 필요한 데이터를 받아올 수 있게해줌.
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  //state로 관리해줄변수들
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0;
  String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = (movies.map((movie) => Image.network(movie.poster))).toList();
    keywords = movies.map((e) => e.keyword).toList();
    likes = movies.map((e) => e.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //상단간격빈공간
          Container(
            padding: EdgeInsets.all(20),
          ),
          //사진
          CarouselSlider(
            items: images,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              },
            ),
          ),
          //장르 텍스트
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          //버튼 세개
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //내가찜한콘텐츠 버튼
                Container(
                  child: Column(
                    children: [
                      likes[_currentPage]
                          ? IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage]
                                      .reference
                                      .update({'like': likes[_currentPage]});
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  likes[_currentPage] = !likes[_currentPage];
                                  movies[_currentPage]
                                      .reference
                                      .update({'like': likes[_currentPage]});
                                });
                              },
                            ),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                //재생버튼
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                //정보버튼
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) {
                                return DetailScreen(
                                  movie: movies[_currentPage],
                                );
                              }));
                        },
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //indicator
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(movies.length, _currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

//indicator
List<Widget> makeIndicator(int length, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < length; i++) {
    results.add(
      Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 2,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i
                ? Color.fromRGBO(
                    255, 255, 255, 0.9) //i가 currentPage면 진한색 나머지는 연한색
                : Color.fromRGBO(255, 255, 255, 0.4)),
      ),
    );
  }
  return results;
}
