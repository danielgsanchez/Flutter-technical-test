import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/country.dart';
import '../../../../domain/usecases/get_countries_usecase.dart';

abstract class CountriesState {}

class LoadingState extends CountriesState {}

class LoadedState extends CountriesState {
  final List<CountryEntity> countries;

  LoadedState(this.countries);
}

class ErrorState extends CountriesState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class NoCountriesFoundState extends CountriesState {}

class LoadCountriesCubit extends Cubit<CountriesState> {
  final GetCountryUseCase getCountryUseCase;

  LoadCountriesCubit(this.getCountryUseCase) : super(LoadingState());

  void loadCountries() {
    getCountryUseCase().then((countries) {
      countries.sort((a, b) => a.name!.compareTo(b.name!));
      if (countries.isEmpty) {
        emit(NoCountriesFoundState());
      } else {
        emit(LoadedState(countries));
      }
    }).catchError((error) {
      emit(ErrorState('Failed to load countries: $error'));
    });
  }
}
