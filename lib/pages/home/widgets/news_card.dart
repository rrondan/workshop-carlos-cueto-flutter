import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  const NewsCard({super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen en la parte superior
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                );
              },
            ),
          ),
          // Título y descripción
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción para abrir la noticia en un navegador
                    print('Abrir noticia: $url');
                  },
                  child: const Text('Leer más'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
