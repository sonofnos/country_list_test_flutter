import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:flutter/material.dart';
import 'package:country_list_test_flutter/country/data/country_service.dart';

class CountryDetailPage extends StatefulWidget {
  final String countryName;

  const CountryDetailPage({super.key, required this.countryName});

  @override
  _CountryDetailPageState createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  Country? country;
  final CountryService countryService = CountryService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCountryDetails();
  }

  Future<void> _loadCountryDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedCountry =
          await countryService.getCountryDetails(widget.countryName);
      setState(() {
        country = fetchedCountry;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load country details: $e')),
      );
    }
  }

  String _formatList(List<String>? list) {
    if (list == null || list.isEmpty) return 'N/A';
    return list.join(', ');
  }

  String _formatLanguages(Map<String, dynamic>? languages) {
    if (languages == null || languages.isEmpty) return 'N/A';
    return languages.values.map((e) => e.toString()).join(', ');
  }

  String _formatCurrencies(Map<String, dynamic>? currencies) {
    if (currencies == null || currencies.isEmpty) return 'N/A';
    return currencies.values
        .map((currency) => currency['name']?.toString() ?? 'N/A')
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : country == null
              ? const Center(child: Text('Failed to load country details.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Official Name: ${country!.name['official']}',
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text('Capital: ${_formatList(country!.capital)}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('Region: ${country!.region}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('Subregion: ${country!.subregion ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('Population: ${country!.population}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(
                            'Languages: ${_formatLanguages(country!.languages)}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(
                            'Currencies: ${_formatCurrencies(country!.currencies)}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('Borders: ${_formatList(country!.borders)}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text('Timezones: ${_formatList(country!.timezones)}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 20),
                        Text('Flag: ${country!.flag}',
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
    );
  }
}
