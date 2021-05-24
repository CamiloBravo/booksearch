import 'package:flutter/material.dart';
import 'package:book_search/src/pages/home_page.dart';
import 'package:book_search/src/pages/libros_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Libreria de Antioquia',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => LibroDetalle(),
      },
    );
  }
}
