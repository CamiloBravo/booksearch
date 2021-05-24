import 'package:flutter/material.dart';
import 'package:book_search/src/models/libro_model.dart';
import 'package:book_search/src/providers/libros_provider.dart';

typedef OnSearchChanged = Future<List<String>> Function(String);

class BookSearch extends SearchDelegate {
  final librosRecientes = [
    'How To Code in Python 3',
    'Learn Programming',
    'Seeing Theory',
    'Full Speed Python',
    'Elementary Algorithms'
  ];

  final librosProvider = new LibrosProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones dentro del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea un wdiget a los resultados que arroja la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ListView.builder(
        itemCount: librosRecientes.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.book),
            title: Text(librosRecientes[i]),
            onTap: () {},
          );
        },
      );
    }

    return FutureBuilder(
      future: librosProvider.buscarLibro(query),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        if (snapshot.hasData) {
          final libros = snapshot.data;
          return ListView(
              children: libros.map((libro) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(libro.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(libro.title),
              subtitle: Text(libro.subtitle),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'detalle', arguments: libro);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
