import 'package:flutter/material.dart';
import 'package:country_list_test_flutter/model/country.dart';

class CountryList extends StatelessWidget {
  final List<Country> countries;

  const CountryList({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(countries[index].name),
          subtitle: Text(countries[index].code),
        );
      },
    );
  }
}
