import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); //검색위젯 컨트롤
  FocusNode focusNode = FocusNode(); //커서 상태
  String _searchText = ""; //현재 검색어 값

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter
            .text; //TextEditingController가 변화를 감지해, _searchText 상태를 변화시키는 코드
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      autofocus: true,
                      controller: _filter,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white60,
                          size: 20,
                        ),
                        suffixIcon: focusNode.hasFocus
                            ? IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = "";
                                  });
                                },
                              )
                            : Container(),
                        hintText: '검색',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    flex: 3,
                  ),
                  focusNode.hasFocus
                      ? Expanded(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _filter.clear();
                                _searchText = '';
                                focusNode.unfocus();
                              });
                            },
                            child: Text("취소"),
                          ),
                        )
                      : Expanded(
                          child: Container(),
                          flex: 0,
                        )
                ],
              ),
            ),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('movie')
          .snapshots(), //cloud firestore 데이터 stream
      builder: (context, snapshots) {
        if (!snapshots.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshots.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<QueryDocumentSnapshot> docs) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in docs) {
      if (d.data().toString().toLowerCase().contains(_searchText.toLowerCase())) {
        searchResults.add(d); //검색 키워드를 포함한 데이터만 리스트에 담음
      }
      else{print("d.data.toString: ${d.data.toString()}");}
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        children: searchResults
            .map((data) => _buildListItem(context, data))
            .toList(), //데이터리스트를를 보여줄수있는 위젯으로 가공
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie =
        Movie.fromSnapshot(data); //firestore 데이터를 가공가능한 데이터형태 Movie로 만들어줌
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        //클릭하면 DetailScreen을 띄워줌
        Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }
}
