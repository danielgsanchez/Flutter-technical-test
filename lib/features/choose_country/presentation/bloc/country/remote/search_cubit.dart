import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/country.dart';
import '../../../../domain/usecases/search_country_usecase.dart';

// SearchCubit is a cubit responsible for searching countries
class SearchCubit extends Cubit<List<CountryEntity>> {
  final SearchCountriesUseCase searchCountriesUseCase;
  Timer? _debounceTimer; // Timer for debouncing search requests

  SearchCubit(this.searchCountriesUseCase) : super([]);

  // Method for performing search with debounce
  void search(String query) {
    _debounceTimer?.cancel(); // Cancel any ongoing debounce timer

    // Starts a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      searchCountriesUseCase.execute(query).then((filteredCountries) {
        emit(filteredCountries); // Emit the filtered countries.
      }).catchError((error) {
        print(
            'Error searching countries: $error'); // Log any errors during search.
      });
    });
  }

  @override
  Future<void> close() {
    _debounceTimer
        ?.cancel(); // Cancel the debounce timer when the cubit is closed.
    return super.close();
  }
}
