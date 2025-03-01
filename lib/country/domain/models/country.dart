
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
    this.capital,
    required this.region,
    this.subregion,
    required this.population,
    this.languages,
    this.currencies,
    this.borders,
    this.timezones,
    required this.flag,
  });

  /// Creates a [Country] object from a JSON map.
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      capital:
          json['capital'] != null ? List<String>.from(json['capital']) : null,
      region: json['region'],
      subregion: json['subregion'],
      population: json['population'],
      languages: json['languages'],
      currencies: json['currencies'],
      borders:
          json['borders'] != null ? List<String>.from(json['borders']) : null,
      timezones: json['timezones'] != null
          ? List<String>.from(json['timezones'])
          : null,
      flag: json['flags']['png'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'capital': capital,
        'region': region,
        'subregion': subregion,
        'population': population,
        'languages': languages,
        'currencies': currencies,
        'borders': borders,
        'timezones': timezones,
        'flags': {'png': flag},
      };
}
