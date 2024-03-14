import '../entities/fixture.dart';
import '../repository/fixture_repository.dart';

// Use case responsible for retrieving fixtures.
class GetFixtureUseCase {
  final FixtureRepository _fixtureRepository;

  GetFixtureUseCase(this._fixtureRepository);

  // Retrieves fixtures for the specified leagueId and season -> returns a list of [FixtureEntity]
  Future<List<FixtureEntity>> call(
      {required int leagueId, required int season}) {
    return _fixtureRepository.getFixtures(
      leagueId: leagueId,
      season: season,
    );
  }
}
