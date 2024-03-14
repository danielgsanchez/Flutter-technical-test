import '../entities/standing.dart';

// Abstract class representing a repository for standings.
abstract class StandingRepository {
  // Retrieves standings for the specified leagueId and season -> returns a list of [StandingEntity]
  Future<List<StandingEntity>> getStanding({
    int? leagueId,
    int? season,
  });
}
