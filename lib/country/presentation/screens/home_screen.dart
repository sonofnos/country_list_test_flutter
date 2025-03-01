import 'package:country_list_test_flutter/country/bloc/country_cubit.dart';
import 'package:country_list_test_flutter/country/data/services/country_service.dart';
import 'package:country_list_test_flutter/country/domain/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_list_test_flutter/country/presentation/screens/country_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountryCubit(countryService: CountryService())..loadCountries(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('African Countries'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a country',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  context.read<CountryCubit>().searchCountry(value);
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<CountryCubit, CountryState>(
          builder: (context, state) {
            if (state is CountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryLoaded) {
              return _buildCountryList(state.filteredCountries, context);
            } else if (state is CountryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildCountryList(List<Country> countries, BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        final country = countries[index];
        return ListTile(
          title: Text(country.name['common']),
          subtitle: Text(
            country.capital?.join(', ') ?? 'No capital',
          ),
          leading: CircleAvatar(
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: country.flag,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailScreen(country: country),
              ),
            );
          },
        );
      },
    );
  }
}
