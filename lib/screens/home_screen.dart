import 'package:flutter/material.dart';
import 'package:toonhelper/models/webtoon_model.dart';
import 'package:toonhelper/services/api_service.dart';
import 'package:toonhelper/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        foregroundColor: Colors.green,
        title: Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      // FutureBuilder : 동적으로 데이터를 가져올 때(API GET) 사용하는 Widget!
      body: FutureBuilder(
        future: webtoons, //가져올 데이터
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 50),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator()); //프로그래스바
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal, //스크롤 방향
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      //separatorBuilder : 아이템(webtoon) 사이에 구분자 위젯
      separatorBuilder: (context, index) => SizedBox(width: 40),
    );
  }
}
