import 'package:ans_app/model/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';
import 'package:ans_app/main.dart';

import 'package:http/http.dart' as http;
void main() {
  test('http commu',() async {
    var response = await http.get(Uri.parse('http://api.airvisual.com/v2/nearest_city?key=8c83ad8e-ee9d-4c1d-a4b9-d47e4bd4cc1c'));

    expect(response.statusCode, 200);
    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');
  });
}
