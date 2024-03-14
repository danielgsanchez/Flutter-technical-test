import '../entities/fixture.dart';

// Define an abstract class for the Fixture Repository
abstract class FixtureRepository {
  // Define a method to fetch fixtures
  // Retrieves fixtures for the specified leagueId and season -> returns a list of [FixtureEntity]
  Future<List<FixtureEntity>> getFixtures({
    int? leagueId, // The ID of the league for which fixtures are requested
    int? season, // The season for which fixtures are requested
  });
}
