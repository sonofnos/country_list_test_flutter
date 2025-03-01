import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            Center(
              child: CircleAvatar(
                radius: 80,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: country.flag,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Capital: ${country.capital?.join(', ') ?? 'No capital'}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Region: ${country.region}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Subregion: ${country.subregion}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text('Borders: ${country.borders?.join(', ') ?? 'No borders'}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
