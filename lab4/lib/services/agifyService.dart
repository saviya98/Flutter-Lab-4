import 'dart:convert';

import 'package:http/http.dart';

class AgifyService {
  static const String apiURL = "https://api.agify.io";
  const AgifyService();

  Future<int?> getAgeFromName(String name) async {
    Response response =
        await get(Uri.parse(apiURL).replace(queryParameters: {"name": name}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["age"];
    }

    throw Exception("Error");
  }
}
