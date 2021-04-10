import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'dart:ui';
/*
HomeScreen에서 CarouselImage의 정보 버튼을 눌렀을때 나오는 화면
*/

class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({this.movie});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;
  @override
  void initState() {
    super.initState();
    like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Stack(children: [
                Container(
                )
              ]),
              makeMenuButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeMenuButton() {
    return Container();
  }
}
