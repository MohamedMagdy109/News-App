import 'package:http/http.dart' as http;
import 'package:News/article.dart';
import 'dart:convert';

class News {
  List<Articles> news = [];
  List<String> searshList = [];
  List<String> searshListImages = [];

  Future<void> getNews(String url) async {
    // String url =
    //     "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      print('succes to getData');
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Articles article = Articles(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
          searshList.add(element['title'].toString());
          searshListImages.add(element['urlToImage'].toString());
        }
      });
    }
  }
}
