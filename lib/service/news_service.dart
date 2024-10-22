import 'dart:convert';
import 'package:workshopcueto/models/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String _apiKey = '{YOUR_API_KEY}';
  final String _url =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=';

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse('$_url$_apiKey'));

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles.map((json) => News.fromJson(json)).toList();
      } catch (e) {
        throw Exception('Failed to load news');
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}
