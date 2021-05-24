import 'package:flutter/material.dart';
import 'package:book_search/src/search/search_delegate.dart';
import 'package:book_search/src/providers/libros_provider.dart';
import 'package:book_search/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final librosProvider = new LibrosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Libreria de Antioquia'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: BookSearch(),
                );
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://thumbs.dreamstime.com/b/pila-de-libros-coloridos-fondo-de-la-educaci%C3%B3n-de-nuevo-escuela-reserve-los-libros-coloridos-del-libro-encuadernado-en-la-tabla-94498175.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: <Widget>[
              _swiperLibros(),
            ],
          ),
        ));
  }

  Widget _swiperLibros() {
    return FutureBuilder(
      future: librosProvider.getDisponibles(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            libros: snapshot.data,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
