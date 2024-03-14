import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/league.dart';
import '../../domain/usecases/get_leagues_usecase.dart';

// States for the leagues screen
abstract class LeaguesState {}

// State indicating that leagues are being loaded
class LoadingState extends LeaguesState {}

// State indicating that leagues have been successfully loaded
class LoadedState extends LeaguesState {
  // List of league entities that will be emitted
  final List<LeagueEntity> leagues;

  LoadedState(this.leagues);
}

// State indicating an error while loading leagues
class ErrorState extends LeaguesState {
  // Error message emitted
  final String errorMessage;

  ErrorState(this.errorMessage);
}

// Cubit for loading leagues.
class LoadLeaguesCubit extends Cubit<LeaguesState> {
  final GetLeagueUseCase getLeagueUseCase;
  LoadLeaguesCubit(this.getLeagueUseCase) : super(LoadingState());

  void loadLeagues(String countryCode) {
    emit(LoadingState()); // Emit loading state.
    getLeagueUseCase(countryCode: countryCode).then((leagues) {
      // Call use case to get leagues
      leagues.sort((a, b) => a.name!.compareTo(b.name!));
      emit(LoadedState(leagues)); // Emit loaded state with fetched leagues
    }).catchError((error) {
      emit(ErrorState('Error loading leagues: $error')); // Emit error state
    });
  }
}
