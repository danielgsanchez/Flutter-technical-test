import '../entities/league.dart';
import '../repository/league_repository.dart';

// GetLeagueUseCase represents the use case for getting leagues
class GetLeagueUseCase {
  final LeagueRepository _leagueRepository;

  GetLeagueUseCase(this._leagueRepository);

  // Call method to get leagues for a specific country
  Future<List<LeagueEntity>> call({required String countryCode}) {
    return _leagueRepository.getLeagues(countryCode: countryCode);
  }
}
