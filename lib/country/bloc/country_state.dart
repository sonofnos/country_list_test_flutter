part of 'country_cubit.dart';

/// Represents the different states of the country list.
@immutable
sealed class CountryState {}

/// Initial state of the country list.
final class CountryInitial extends CountryState {}

/// State indicating that the country list is being loaded.
final class CountryLoading extends CountryState {}

/// State indicating that the country list has been loaded successfully.
final class CountryLoaded extends CountryState {
  final List<Country> countries;
  final List<Country> filteredCountries;
  final Country? selectedCountry;

  CountryLoaded(
      {required this.countries,
      required this.filteredCountries,
      this.selectedCountry});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryLoaded &&
        other.countries == countries &&
        other.filteredCountries == filteredCountries &&
        other.selectedCountry == selectedCountry;
  }

  @override
  int get hashCode =>
      countries.hashCode ^
      filteredCountries.hashCode ^
      selectedCountry.hashCode;
}

/// State indicating that an error occurred while loading the country list.
final class CountryError extends CountryState {
  final String message;

  CountryError({required this.message});
}
