import 'package:flutter/material.dart';
import 'package:toonhelper/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector : 제스처(이벤트) 감지하는 Widget
      onTap: () {
        // 클릭 이벤트
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(10, 10),
                  color: Colors.black.withAlpha(125),
                ),
              ],
            ),
            child: Image.network(
              thumb,
              headers: const {
                'Referer': 'https://comic.naver.com',
              }, // 403에러가 발생해서 headers 추가
            ),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
