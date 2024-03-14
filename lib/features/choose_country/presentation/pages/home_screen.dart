import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/remote/country_service.dart';
import '../../data/repository/country_repository_impl.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/usecases/search_country_usecase.dart';
import '../bloc/country/remote/load_country_cubit.dart';
import '../bloc/country/remote/search_cubit.dart';
import '../widgets/country_list_widget.dart';
import '../widgets/search_bar_widget.dart' as sb;

// HomeScreen represents the home screen of the application.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState is the state for the HomeScreen widget.
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final LoadCountriesCubit _loadCountriesCubit;
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    // Initializing LoadCountriesCubit and SearchCubit.
    _loadCountriesCubit = LoadCountriesCubit(
        GetCountryUseCase(CountryRepositoryImpl(CountryService())));
    _searchCubit = SearchCubit(
        SearchCountriesUseCase(CountryRepositoryImpl(CountryService())));
    // Loading countries from the cubit method.
    _loadCountriesCubit.loadCountries();
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Get football insights and stats'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [Colors.white, Colors.green],
              stops: [0.2, 1.0],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb.SearchBar(
                  searchController:
                      _searchController, // Passing search controller to the SearchBar widget
                  onSearchTextChanged:
                      _searchCubit.search, // Handling search text changes
                ),
                const SizedBox(height: 16),
                BlocBuilder<SearchCubit, List<CountryEntity>>(
                  bloc: _searchCubit,
                  builder: (context, filteredCountries) {
                    return BlocBuilder<LoadCountriesCubit, CountriesState>(
                      bloc: _loadCountriesCubit,
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Displaying loading indicator
                        } else if (state is LoadedState) {
                          List<CountryEntity> countriesToDisplay;
                          if (_searchController.text.isEmpty) {
                            countriesToDisplay = state.countries;
                          } else {
                            countriesToDisplay = filteredCountries;
                          }

                          if (countriesToDisplay.isEmpty) {
                            return const Center(
                                child: Text(
                                    "No countries found")); // Displaying message if no countries are found while searching
                          } else {
                            return CountryList(
                                filteredCountries:
                                    countriesToDisplay); // Displaying list of countries.
                          }
                        } else if (state is ErrorState) {
                          return Center(
                            child: Column(
                              children: [
                                const Text(
                                    "Error loading countries"), // Displaying error message.
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    _loadCountriesCubit.loadCountries();
                                  },
                                  child: const Text(
                                      "Retry"), // Retry loading countries -> will call the loadCountries method in the cubit again.
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(
                                "Error loading countries"), // Displaying error message (some unknown problem happened)
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
