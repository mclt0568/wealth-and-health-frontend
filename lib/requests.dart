import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchRequest {
  FetchRequest(this.route);

  final String route;
  static final String _API = "http://wealth-and-health.frankium.com:5000/";
  static String token = "";

  String _method = "GET";
  Object? _payload;

  static Uri API(String route) {
    return Uri.parse(_API + route);
  }

  static setAuth(String token) {
    FetchRequest.token = token;
  }

  FetchRequest post() {
    _method = "POST";
    return this;
  }

  FetchRequest get() {
    _method = "GET";
    return this;
  }

  FetchRequest put() {
    _method = "PUT";
    return this;
  }

  FetchRequest delete() {
    _method = "DELETE";
    return this;
  }

  FetchRequest attach(final Object? _payload) {
    this._payload = _payload;
    return this;
  }

  Future<http.Response> commit() async {
    final uri = API(route);
    final headers = {'Content-Type': 'application/json'};

    String body = "";
    if (_payload != null) {
      body = jsonEncode(_payload);
    }

    if (FetchRequest.token != "") {
      headers['token'] = FetchRequest.token;
    }

    if (_method == "POST") {
      return await http.post(uri, headers: headers, body: body);
    }

    if (_method == "PUT") {
      return await http.put(uri, headers: headers, body: body);
    }

    if (_method == "DELETE") {
      return await http.delete(uri, headers: headers, body: body);
    }

    return await http.get(uri, headers: headers);
  }
}
