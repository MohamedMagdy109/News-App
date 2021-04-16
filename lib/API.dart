import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'article.dart';

class Data {
  Future getData() async {
    String myUrl =
        "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053";
    http.Response response = await http
        .get(
          myUrl,
        )
        .catchError((error) => print(error));

    ///requist
    if (response.statusCode == 200) {
      print('sucssessss to Request DATA');
      print('num = ' + jsonDecode(response.body)["articles"].toString());
      print('num = ' +
          jsonDecode(response.body)["articles"][1]['author'].toString());
      return jsonDecode(response.body).toString();
    } else {
      print('failed to Request session: ');
    }
  }
}
