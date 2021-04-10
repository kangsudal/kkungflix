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
                  width: double.maxFinite, //double이 저장할 수 있는 가장 큰 값
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'images/' + widget.movie.poster,
                      ),  //BackdropFilter와 ImageFilter로 blur처리
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.1),
                        child: Container(
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                              child:
                                  Image.asset('images/' + widget.movie.poster),
                              height: 300,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
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
