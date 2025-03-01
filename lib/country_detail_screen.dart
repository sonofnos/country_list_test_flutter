import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name['common']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              country.flag,
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text('Capital: ${country.capital?.join(', ') ?? 'N/A'}'),
            const SizedBox(height: 8),
            Text('Languages: ${country.languages?.values.join(', ') ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
