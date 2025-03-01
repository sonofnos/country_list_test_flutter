import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:http/http.dart' as http;

/// Service class responsible for fetching country data.
class CountryService {
  final Duration timeoutDuration;

  CountryService({this.timeoutDuration = const Duration(seconds: 10)});

  /// Fetches a list of [Country] objects from the API endpoint.
  Future<List<Country>> getCountries({int maxRetries = 3}) async {
    final client = http.Client();
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await client
            .get(Uri.parse(
                'https://restcountries.com/v3.1/region/africa?status=true'))
            .timeout(timeoutDuration);

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((json) => Country.fromJson(json)).toList();
        } else {
          log('Failed to load countries: ${response.statusCode}');
          if (response.statusCode == HttpStatus.tooManyRequests) {
            // If rate limited, back off and retry
            await Future.delayed(const Duration(seconds: 5));
          } else {
            throw Exception(
                'Failed to load countries: ${response.statusCode}'); // Don't retry other errors
          }
        }
      } catch (e) {
        log('Error loading countries: $e');
        if (e is SocketException ||
            e is TimeoutException ||
            e is HandshakeException) {
          retryCount++;
          log('Retrying ($retryCount/$maxRetries) after error: $e');
          await Future.delayed(
              const Duration(seconds: 2)); // Simple delay before retrying
        } else {
          throw Exception(
              'Error loading countries: $e'); // Don't retry other errors
        }
      } finally {
        if (retryCount == maxRetries) {
          client.close();
        }
      }
    }

    throw Exception('Failed to load countries after multiple retries');
  }

  /// Fetches a [Country] object by name from the API endpoint.
  Future<Country> getCountryByName(String name, {int maxRetries = 3}) async {
    final client = http.Client();
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await client
            .get(Uri.parse(
                'https://restcountries.com/v3.1/name/$name?status=true'))
            .timeout(timeoutDuration);

        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          if (data.isNotEmpty) {
            return Country.fromJson(data.first);
          } else {
            throw Exception('Country not found');
          }
        } else {
          log('Failed to load country: ${response.statusCode}');
          if (response.statusCode == HttpStatus.tooManyRequests) {
            // If rate limited, back off and retry
            await Future.delayed(const Duration(seconds: 5));
          } else {
            throw Exception(
                'Failed to load country: ${response.statusCode}'); // Don't retry other errors
          }
        }
      } catch (e) {
        log('Error loading country: $e');
        if (e is SocketException ||
            e is TimeoutException ||
            e is HandshakeException) {
          retryCount++;
          log('Retrying ($retryCount/$maxRetries) after error: $e');
          await Future.delayed(
              const Duration(seconds: 2)); // Simple delay before retrying
        } else {
          throw Exception(
              'Error loading country: $e'); // Don't retry other errors
        }
      } finally {
        if (retryCount == maxRetries) {
          client.close();
        }
      }
    }

    throw Exception('Failed to load country after multiple retries');
  }
}
