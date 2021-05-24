class Libros {
  List<Book> items = [];
  Libros();
  Libros.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final book = new Book.fromJasonMap(item);
      items.add(book);
    }
  }
}

class Book {
  String title;
  String subtitle;
  String isbn13;
  String price; //Type Price
  String image;
  String url;

  Book({
    this.title,
    this.subtitle,
    this.isbn13,
    this.price,
    this.image,
    this.url,
  });

  Book.fromJasonMap(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    isbn13 = json['isbn13'];
    price = json['price'];
    image = json['image'];
    url = json['url'];
  }

  getPosterImg() {
    if (image == null) {
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    } else {
      return '$image';
    }
  }
}

// enum Price { THE_000, THE_1683, THE_9008, THE_3399 }
