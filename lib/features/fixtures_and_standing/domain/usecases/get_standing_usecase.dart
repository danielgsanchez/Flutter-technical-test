import '../entities/standing.dart';
import '../repository/standing_repository.dart';

// Use case responsible for retrieving standings
class GetStandingUseCase {
  final StandingRepository _standingRepository;

  GetStandingUseCase(this._standingRepository);

  // Retrieves standings for the specified leagueId and season -> returns a list of [StandingEntity]
  Future<List<StandingEntity>> call(
      {required int leagueId, required int season}) {
    return _standingRepository.getStanding(
      leagueId: leagueId,
      season: season,
    );
  }
}
