import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/UiC.dart';



class Api{

  Map<String, String> header = {
    'Content-Type': 'application/json',

    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept'
  };

  Future<dynamic> getAll(String url) async {
    Uri uri = Uri.parse("${UiC.url}${url}");
    final response = await http.get(uri, headers: header);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final  json = jsonDecode(utf8.decode(response.bodyBytes));

      return json;
    } else {
      throw Exception("Error");
    }
  }

  Future<dynamic> post(String url, Object object) async{
    Uri uri = Uri.parse("${UiC.url}${url}");

    final response = await http.post(uri, body: json.encode(object), headers: header);

    if (response.statusCode == 200
        || response.statusCode == 201) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));

      return json; //json.map((e) => Catalog.fromJson(e)).toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<bool> delete(String url, String id) async{
    Uri uri = Uri.parse("${UiC.url}${url}").replace(queryParameters: {"id": id});

    final response = await http.delete(uri, headers: header);

    if (response.statusCode == 200
        || response.statusCode == 201) {

      return true;
    } else {
      throw Exception("Error");
      return false;
    }
  }
}
