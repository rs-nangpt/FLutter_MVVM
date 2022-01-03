import 'dart:convert';

import 'package:http/http.dart' as http;


class APIService {
  final String _baseURL = "https://reqres.in/api/";
  final String _loginAPI = "login";
  final Map<String, String> headers = {"Content-type": "application/json"};

  Future <dynamic> userLogin(String email, String password) async {
    dynamic requestBody =
        jsonEncode(<String, String>{'email': email, 'password': password});
    final response = await http.post(Uri.parse(_baseURL + _loginAPI),
        body: requestBody, headers: headers);
    dynamic responseJson = jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return responseJson;
  }
}
