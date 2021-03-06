import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/widget/box_slider.dart';
import 'package:netflix_clone/widget/carousel_slider.dart';
import 'package:netflix_clone/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Movie> movies = [
  //   Movie.fromMap({
  //     'title': '나의 가족 나의 도시',
  //     'keyword': '가족/코미디/드라마',
  //     'poster': 'poster_myfamily.jpg',
  //     'like': false,
  //   }),
  //   Movie.fromMap({
  //     'title': '사랑의 불시착',
  //     'keyword': '사랑/로맨스/판타지',
  //     'poster': 'poster_love.jpg',
  //     'like': false,
  //   }),
  //   Movie.fromMap({
  //     'title': '뷰티풀마인드',
  //     'keyword': '드라마/로맨스',
  //     'poster': 'a-beautiful-mind.jpg',
  //     'like': false,
  //   }),
  //   Movie.fromMap({
  //     'title': '굿윌헌팅',
  //     'keyword': '드라마/로맨스',
  //     'poster': 'good-will-hunting.png',
  //     'like': false,
  //   }),
  //   Movie.fromMap({
  //     'title': 'Life as a house',
  //     'keyword': '드라마/패밀리',
  //     'poster': 'Life-as-a-house.jpg',
  //     'like': false,
  //   }),
  //   Movie.fromMap({
  //     'title': '메멘토',
  //     'keyword': '스릴러/미스터리',
  //     'poster': 'memento.jpg',
  //     'like': false,
  //   }),
  // ];
  // 더미데이터 대신 Firebase 콘솔에서 cloud firestore에 데이터입력해서 받아옴
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    streamData = firestore.collection('movie').snapshots();
    super.initState();
  }

  Widget _fetchData(BuildContext context) {
    //stream으로 데이터를 추출하여 위젯으로 만드는 과정
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context,snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.docs);
      });
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshots) {
    List<Movie> movies = (snapshots.map((snapshot) => Movie.fromSnapshot(snapshot))).toList();
    return ListView(
      children: [
        Stack(
          children: [
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CirclesSlider(
          movies: movies,
        ),
        BoxSlider(
          movies: movies,
        ),
      ],
    );  
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
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
