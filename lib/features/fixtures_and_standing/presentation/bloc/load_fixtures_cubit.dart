import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/fixture.dart';
import '../../domain/usecases/get_fixtures_usecase.dart';

// States for the fixtures screen
abstract class FixturesState {}

// State indicating that fixtures are being loaded
class LoadingState extends FixturesState {}

// State indicating that fixtures have been successfully loaded
class LoadedState extends FixturesState {
  // List of fixture entities that will be emitted
  final List<FixtureEntity> fixtures;

  LoadedState(this.fixtures);
}

// State indicating an error while loading fixtures
class ErrorState extends FixturesState {
  // Error message emitted
  final String errorMessage;

  ErrorState(this.errorMessage);
}

// Cubit for loading fixtures.
class LoadFixturesCubit extends Cubit<FixturesState> {
  final GetFixtureUseCase getFixturesUseCase;
  LoadFixturesCubit(this.getFixturesUseCase) : super(LoadingState());

  // Loads fixtures for the specified leagueId and season.
  void loadFixtures(int leagueId, int season) {
    emit(LoadingState()); // Emit loading state.
    getFixturesUseCase
        .call(
            leagueId: leagueId, season: season) // Call use case to get fixtures
        .then((fixtures) {
      emit(LoadedState(fixtures)); // Emit loaded state with fetched fixtures
    }).catchError((error) {
      emit(ErrorState('Error loading fixtures: $error')); // Emit error state
    });
  }
}
