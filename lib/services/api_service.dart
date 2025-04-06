import 'dart:convert';

import 'package:http/http.dart'
    as http; // API 사용 시 필요한 패키지 : pubspec.yaml 파일에 추가하면 자동 설치됨
import 'package:toonhelper/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //비동기 메서드라 그냥 List<WebtoonModel>로 return할 수 없어서 Future<>로 return
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
