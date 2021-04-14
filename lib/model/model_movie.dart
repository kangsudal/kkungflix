import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final DocumentReference reference; //Firebase firestore에 데이터 컬럼을 참조할 수 있는 링크

  Movie.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
  //reference를 이용해 데이터에 대한 CRUD 기능을 처리할수있다
  @override
  String toString() => "Movie<$title:$keyword>";
}
