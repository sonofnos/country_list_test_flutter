import 'dart:convert';
import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:http/http.dart' as http;

class CountryService {
  Future<Country> getCountryDetails(String name) async {
    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/name/$name'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        if (body.isNotEmpty) {
          return Country.fromJson(body.first);
        } else {
          throw Exception('No country found with name: $name');
        }
      } else {
        throw Exception(
            'Failed to load country details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load country details: $e');
    }
  }
}
