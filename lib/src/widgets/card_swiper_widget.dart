import 'package:flutter/material.dart';
import 'package:book_search/src/models/libro_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Book> libros;
  CardSwiper({@required this.libros});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.9,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: libros[index].isbn13,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: libros[index]),
                  child: FadeInImage(
                    image: NetworkImage(libros[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: libros.length,
      ),
    );
  }
}
