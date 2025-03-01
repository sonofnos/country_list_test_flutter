import 'package:bloc/bloc.dart';
import 'package:country_list_test_flutter/country/data/services/country_service.dart';
import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:async';

part 'country_state.dart';

/// Cubit responsible for managing the state of the country list.
class CountryCubit extends Cubit<CountryState> {
  final CountryService countryService;
  Timer? _debounceTimer;

  CountryCubit({required this.countryService}) : super(CountryInitial());

  List<Country> _countries = [];

  /// Loads the list of countries from the [CountryService].
  Future<void> loadCountries() async {
    emit(CountryLoading());
    try {
      _countries = await countryService.getCountries();
      _countries.sort((a, b) => a.name['common'].compareTo(b.name['common']));
      emit(CountryLoaded(countries: _countries, filteredCountries: _countries));
    } catch (e) {
      emit(CountryError(message: e.toString()));
    }
  }

  /// Searches for countries based on the given [query].
  void searchCountry(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    final filteredCountries = _countries
        .where((country) => (country.name['common'] as String)
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    Country? selected;
    if (state is CountryLoaded &&
        (state as CountryLoaded).selectedCountry != null) {
      selected = filteredCountries.firstWhereOrNull((element) =>
          element.name['common'] ==
          (state as CountryLoaded).selectedCountry!.name['common']);
    }
    emit(CountryLoaded(
        countries: _countries,
        filteredCountries: filteredCountries,
        selectedCountry: selected));
  }

  void selectCountry(Country country) {
    emit(CountryLoaded(
        countries: _countries,
        filteredCountries: (state as CountryLoaded).filteredCountries,
        selectedCountry: country));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
