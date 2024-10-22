# Workshop Carlos Cueto Fernandini - Flutter

Este proyecto es para el taller de Flutter que se llevará a cabo el 22 de octubre de 2024 en 
el instituto Carlos Cueto Fernandini.

## Getting Started

Este es un proyecto de Flutter, aca esta la documentación si desean empezar.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Empecemos con el taller

El primer paso que vamos hacer es crear un proyecto de Flutter, siguiendo las indicaciones del instructor.

El segundo paso que vamos hacer es modificar el archivo `main.dart`, para que se vea como el siguiente código:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Noticias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
```

Se darán cuenta que no se ha creado la clase HomePage, por lo que vamos a crearla. 
Van a crearlo dentro de la carpeta `lib/pages/home`, y el archivo se llamará `home_page.dart`.

```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias de Flutter"),
      ),      
      body: Container(),
    );
  }
}
```

Una vez lo creen, vamos a modificar el archivo `main.dart` para agregar la importación de la clase HomePage.:

```dart
import 'package:flutter/material.dart';
import '/pages/home/home_page.dart';
```

Ahora vamos a correr el proyecto para ver que todo este funcionando correctamente.

## Creando nuestra primera lista de noticias

Vamos a modificar el archivo `home_page.dart` para agregar una lista de noticias.

```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> noticias = [
    "Flutter 3.0 ha sido lanzado",
    "La comunidad Flutter crece rápidamente",
    "Nuevas herramientas para Flutter Developers",
    "Google lanza nuevo soporte para Flutter en Fuchsia",
    "Cómo optimizar tus apps en Flutter",
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias de Flutter"),
      ),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(noticias[index]),
            subtitle: Text('Publicado el día ${index + 1} de octubre'),
            leading: Icon(Icons.article),
            onTap: () {
              // Puedes agregar una acción cuando se pulse en la noticia
            },
          );
        },
      ),
    );
  }
}
```

Ahora si compilas la app te saldra un listado de noticias.

## Menu Lateral

Para que nuestra aplicación se vea como una app real de noticias, vamos a agregar un menú lateral.
Esto se hace con el componente `Drawer` de Flutter, que vamos a agregar en el `Scaffold` de la `HomePage`.

```dart
    drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            
          ],
        ),
      ),
```

Como pueden ver, el `Drawer` recibe un `child` de tipo `ListView`, que es una lista de widgets.
Ahora vamos a agregar esos children, que serán los items del menú lateral.

Primero agregaremos el header del menú lateral, que es un `UserAccountsDrawerHeader`.
```dart
    const UserAccountsDrawerHeader(
        accountName: Text("Richard Developer"),
        accountEmail: Text("richard.dev@example.com"),
        currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(
          "assets/images/profile_placeholder.png"),
        ),
    ),
```
Se dieron que ahora necesitamos una imagen que no tenemos, descarguenlo de este repositorio la carpeta es assets, descarguenlo y copienlo a su proyecto
Para que funcione la imagen debemos cambiar el archivo de dependencias de flutter que es el `pubspec.yaml` y agregar la siguiente linea:

```yaml
  assets:
    - assets/images/
```

Ahora vamos a agregar los items del menú lateral, que serán `ListTile` con un `leading` y un `title`.

```dart
    ListTile(
      leading: const Icon(Icons.home),
      title: const Text("Inicio"),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    ListTile(
      leading: const Icon(Icons.favorite),
      title: const Text("Favoritos"),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    ListTile(
      leading: const Icon(Icons.settings),
      title: const Text("Configuraciones"),
      onTap: () {
        Navigator.pop(context);
      },
    ),
    ListTile(
      leading: const Icon(Icons.logout),
      title: const Text("Cerrar sesión"),
      onTap: () {
        Navigator.pop(context);
      },
    ),
```

Listo con esto deberias tener tu primer app desarrollado en Flutter! 

¡Muchas felicidades!

Ahora vamos a hacer algo más interesante, vamos a integrar una API de noticias para mostrar noticias reales en nuestra app.

## Integración de NewsAPI

Para esta aplicación, vamos a integrar la API de [NewsAPI](https://newsapi.org) 
para mostrar titulares de noticias en la categoría de negocios. 
A continuación se describen los pasos para implementar esta funcionalidad.

### Paso 1: Crear el Modelo `News`

El modelo `News` refleja la estructura de los datos recibidos desde la API. 
Vamos a crear un archivo `news.dart` en la carpeta `lib/models` y agregar el siguiente código:

```dart
class News {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  News({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
```

### Paso 2: Crear el Servicio `NewsService`
Vamos a crear el servicio que va a hacer la petición a la API de NewsAPI.
Para esto primero hay que importar la librería `http` en el archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2
```
o desde su terminal corran el siguiente comando    
```bash
flutter pub add http
```

Ahora vamos a crear un archivo `news_service.dart` en la carpeta `lib/services` y agregar el siguiente código:

```dart
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
```

Ahora para finalizar vamos a actualizar el archivo `home_page.dart` para mostrar las noticias reales en lugar de las noticias estáticas.

```dart
Widget build(BuildContext context) {
return Scaffold(
  /* el resto del codigo (¡¡¡SOLO COPIA EL BODY!!!) */
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
```

Solo deben actualizar el body, el resto se mantiene igual, corren la app y deberia funcionar.

Si no funciona revisen que hayan agregado el API_KEY en el archivo `news_service.dart` y que hayan importado correctamente las librerias.

y Si aun asi les sale error en la App, tienes este repositorio donde podas ver el codigo que esta probado y si funciona correctamente.

¡Felicidades! Has completado el taller de Flutter.

