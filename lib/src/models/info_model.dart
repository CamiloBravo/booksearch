class Info {
  String error;
  String title;
  String subtitle;
  String authors;
  String publisher;
  String language;
  String isbn10;
  String isbn13;
  String pages;
  String year;
  String rating;
  String desc;
  String price;
  String image;
  String url;
  // Pdf pdf;

  Info({
    this.error,
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.language,
    this.isbn10,
    this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.image,
    this.url,
    // this.pdf,
  });

  Info.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'];
    publisher = json['publisher'];
    language = json['language'];
    isbn10 = json['isbn10'];
    isbn13 = json['isbn13'];
    pages = json['pages'];
    year = json['year'];
    rating = json['rating'];
    desc = json['desc'];
    price = json['price'];
    image = json['image'];
    url = json['url'];
  }

  getImg() {
    if (image == null) {
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    } else {
      return '$image';
    }
  }
}

// class Pdf {
//   String chapter2;
//   String chapter5;

//   Pdf({
//     this.chapter2,
//     this.chapter5,
//   });
// }
