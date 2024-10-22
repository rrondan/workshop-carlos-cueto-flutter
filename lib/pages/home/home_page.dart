import 'package:flutter/material.dart';
import 'package:workshopcueto/models/news.dart';
import 'package:workshopcueto/service/news_service.dart';
import 'widgets/news_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> noticias = [
    "Flutter 3.0 ha sido lanzado",
    "La comunidad Flutter crece rápidamente",
    "Nuevas herramientas para Flutter Developers",
    "Google lanza nuevo soporte para Flutter en Fuchsia",
    "Cómo optimizar tus apps en Flutter",
  ];

  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: FutureBuilder<List<News>>(
        future: newsService.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles'));
          }

          final newsList = snapshot.data!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return NewsCard(
                title: news.title,
                description: news.description,
                imageUrl: news.urlToImage,
                url: news.url,
              );
            },
          );
        },
      ),
    );
  }
}
