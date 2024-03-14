import 'package:get_it/get_it.dart';

import '../features/choose_country/data/data_sources/remote/country_service.dart';
import '../features/choose_country/data/repository/country_repository_impl.dart';
import '../features/choose_country/domain/usecases/get_countries_usecase.dart';
import '../features/choose_country/domain/usecases/search_country_usecase.dart';
import '../features/choose_country/presentation/bloc/country/remote/load_country_cubit.dart';
import '../features/choose_country/presentation/bloc/country/remote/search_cubit.dart';
import '../features/choose_league/data/data_sources/remote/league_service.dart';
import '../features/choose_league/data/repository/league_repository_impl.dart';
import '../features/choose_league/domain/repository/league_repository.dart';
import '../features/choose_league/domain/usecases/get_leagues_usecase.dart';
import '../features/choose_league/presentation/bloc/load_league_cubit.dart';
import '../features/fixtures_and_standing/data/data_sources/remote/fixture_service.dart';
import '../features/fixtures_and_standing/data/repository/fixture_repository_impl.dart';
import '../features/fixtures_and_standing/domain/repository/fixture_repository.dart';
import '../features/fixtures_and_standing/domain/usecases/get_fixtures_usecase.dart';
import '../features/fixtures_and_standing/domain/usecases/get_standing_usecase.dart';
import '../features/fixtures_and_standing/presentation/bloc/load_fixtures_cubit.dart';
import '../features/fixtures_and_standing/presentation/bloc/load_standing_cubit.dart';

// Create an instance of GetIt
final getIt = GetIt.instance;

// Set up dependencies using GetIt
void setupDependencies() {
  // Repositories
  getIt.registerLazySingleton<CountryService>(() => CountryService());
  getIt.registerLazySingleton<CountryRepositoryImpl>(
      () => CountryRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LeagueService>(() => LeagueService());
  getIt.registerLazySingleton<LeagueRepository>(
      () => LeagueRepositoryImpl(getIt(), 'EN'));
  getIt.registerLazySingleton<FixtureService>(() => FixtureService());
  getIt.registerLazySingleton<FixtureRepository>(
      () => FixtureRepositoryImpl(getIt(), 33, 2023));

  // Use Cases
  getIt.registerLazySingleton<GetCountryUseCase>(
      () => GetCountryUseCase(getIt()));
  getIt.registerLazySingleton<SearchCountriesUseCase>(
      () => SearchCountriesUseCase(getIt()));
  getIt
      .registerLazySingleton<GetLeagueUseCase>(() => GetLeagueUseCase(getIt()));
  getIt.registerLazySingleton<GetFixtureUseCase>(
      () => GetFixtureUseCase(getIt()));
  getIt.registerLazySingleton<GetStandingUseCase>(
      () => GetStandingUseCase(getIt()));

  // Cubits: we specially need this part because they need to be as high as possible in the widget tree (so we initialite them in main.dart)
  getIt.registerFactory<LoadCountriesCubit>(() => LoadCountriesCubit(getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));
  getIt.registerFactory<LoadLeaguesCubit>(() => LoadLeaguesCubit(getIt()));
  getIt.registerFactory<LoadFixturesCubit>(() => LoadFixturesCubit(getIt()));
  getIt.registerFactory<LoadStandingCubit>(() => LoadStandingCubit(getIt()));
}
