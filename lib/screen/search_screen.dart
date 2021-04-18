import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
