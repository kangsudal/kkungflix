import 'package:flutter/material.dart';
import 'package:netflix_clone/screen/home_screen.dart';
import 'package:netflix_clone/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KkungFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [
              HomeScreen(),
              Container(child: Center(child:Text('search'),),),
              Container(child: Center(child:Text('save'),),),
              Container(child: Center(child:Text('more'),),),
            ],
            physics: NeverScrollableScrollPhysics(), //스크롤이안되게
          ),
          bottomNavigationBar: Bottom(),//NavigationBar 설정
        ),
      ),
    );
  }
}
