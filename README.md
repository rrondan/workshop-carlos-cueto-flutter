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

El segundo paso que vamos hacer es modificar el archivo main.dart, para que se vea como el siguiente código:

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
Van a crearlo dentro de la carpeta lib/pages/home, y el archivo se llamará home_page.dart.

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

Una vez lo creen, vamos a modificar el archivo main.dart para agregar la importación de la clase HomePage.:

```dart
import 'package:flutter/material.dart';
import '/pages/home/home_page.dart';
```
## Integración de NewsAPI





En esta aplicación, hemos integrado la API de [NewsAPI](https://newsapi.org) 
para mostrar titulares de noticias en la categoría de negocios. A continuación se describen los pasos para implementar esta funcionalidad sin el uso de librerías externas como Freezed, Dio o Retrofit.

### Paso 1: Crear el Modelo `News`

El modelo `News` refleja la estructura de los datos recibidos desde la API. 
Aquí un ejemplo de cómo crear este modelo:

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
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }
}
```