import '../../domain/entities/fixture.dart';
import '../../domain/repository/fixture_repository.dart';
import '../data_sources/remote/fixture_service.dart';

// Define a class representing the implementation of the FixtureRepository
class FixtureRepositoryImpl implements FixtureRepository {
  final FixtureService _fixtureService;
  final int leagueId;
  final int season;

  FixtureRepositoryImpl(
    this._fixtureService,
    this.leagueId,
    this.season,
  );

  // Implementation of the getFixtures method from the FixtureRepository interface
  @override
  Future<List<FixtureEntity>> getFixtures({int? leagueId, int? season}) async {
    try {
      // Call the service to get fixture data
      final fixtures = await _fixtureService.getFixtures(
          leagueId: leagueId ?? this.leagueId, season: season ?? this.season);
      return fixtures; // Return the fetched fixture data
    } catch (e) {
      // Handle error as needed
      print('Error getting countries: $e');
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }
}
