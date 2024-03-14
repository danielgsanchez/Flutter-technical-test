import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/standing.dart';
import '../../domain/usecases/get_standing_usecase.dart';

// States for the standing screen
abstract class StandingStates {}

// State indicating that standings are being loaded
class LoadingState extends StandingStates {}

// State indicating that standings have been successfully loaded
class LoadedState extends StandingStates {
  // List of standing entities (this will be emitted when loaded)
  final List<StandingEntity> standing;

  LoadedState(this.standing);
}

// State indicating an error while loading standings
class ErrorState extends StandingStates {
  //It'll emit an error message
  final String errorMessage;

  ErrorState(this.errorMessage);
}

class LoadStandingCubit extends Cubit<StandingStates> {
  final GetStandingUseCase getStandingUseCase;
  LoadStandingCubit(this.getStandingUseCase) : super(LoadingState());

  // Loads standings for the specified [leagueId] and [season]
  void loadStanding(int leagueId, int season) {
    emit(LoadingState()); // Emit loading state
    getStandingUseCase
        .call(
            leagueId: leagueId,
            season: season) // Call use case to get standings
        .then((standing) {
      emit(LoadedState(standing)); // Emit loaded state with fetched standings
    }).catchError((error) {
      emit(ErrorState(
          'Error loading standing: $error')); // Emit error state if an error occurs
    });
  }
}
