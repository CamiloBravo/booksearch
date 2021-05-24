import 'dart:convert';
import 'package:book_search/src/models/info_model.dart';
import 'package:book_search/src/models/libro_model.dart';
import 'package:http/http.dart' as http;

class LibrosProvider {
  String _url = 'api.itbook.store';

  Future<List<Book>> getDisponibles() async {
    final url = Uri.https(_url, '1.0/new');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final libros = new Libros.fromJsonList(decodedData['books']);

    return libros.items;
  }

  Future<Info> getInfo(String numBook) async {
    final url = Uri.https(_url, '1.0/books/$numBook');
    final resp = await http.get(url);

    return Info.fromJson(jsonDecode(resp.body));
  }

  Future<List<Book>> buscarLibro(String query) async {
    final url = Uri.https(_url, '1.0/search/$query');
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final libros = new Libros.fromJsonList(decodedData['books']);

    return libros.items;
  }
}
