import 'package:flutter/material.dart';
import 'package:book_search/src/models/info_model.dart';
import 'package:book_search/src/providers/libros_provider.dart';
import 'package:book_search/src/models/libro_model.dart';

class LibroDetalle extends StatelessWidget {
  final librosProvider = new LibrosProvider();

  @override
  Widget build(BuildContext context) {
    final Book libro = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/originals/16/6a/68/166a68cd49c254105d5c22bfd02cc34e.jpg'),
              fit: BoxFit.cover)),
      child: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(libro),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _descripcion(libro)
            ]),
          )
        ],
      ),
    ));
  }

  Widget _crearAppBar(Book libro) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(libro.getPosterImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _descripcion(Book libro) {
    return FutureBuilder<Info>(
      future: librosProvider.getInfo(libro.isbn13),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _posterTitulo(snapshot.data, context);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _posterTitulo(Info libroInfo, BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    libroInfo.title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(libroInfo.subtitle,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                  Text(libroInfo.authors,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            )),
        Row(
          children: [
            Hero(
              tag: libroInfo.isbn13,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(libroInfo.getImg()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Editora: ' + libroInfo.publisher,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('Año: ' + libroInfo.year,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                  Text('Páginas: ' + libroInfo.pages,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                  Text('Precio: ' + libroInfo.price,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border),
                      Text(libroInfo.rating,
                          style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Text(
            libroInfo.desc,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
