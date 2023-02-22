import 'package:get/get.dart';


import '../api/Api.dart';

class ApiConnector extends GetConnect{

  final api = Api();

  Future<List<dynamic>> getAll(String url) async {
    final json = await api.getAll(url);

    return json;
  }


}