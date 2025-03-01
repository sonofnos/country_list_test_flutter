/// Represents a country with its name, capital, and flag.
class Country {
  final Map<String, dynamic> name;
  final List<String>? capital;
  final String region;
  final String? subregion;
  final int population;
  final Map<String, dynamic>? languages;
  final Map<String, dynamic>? currencies;
  final List<String>? borders;
  final List<String>? timezones;
  final String flag;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.languages,
    required this.currencies,
    required this.borders,
    required this.timezones,
    required this.flag,
  });

  /// Creates a [Country] object from a JSON map.
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      capital: (json['capital'] as List?)?.cast<String>(),
      region: json['region'],
      subregion: json['subregion'],
      population: json['population'],
      languages: json['languages'],
      currencies: json['currencies'],
      borders: (json['borders'] as List?)?.cast<String>(),
      timezones: (json['timezones'] as List?)?.cast<String>(),
      flag: json['flags']['png'],
    );
  }
}
