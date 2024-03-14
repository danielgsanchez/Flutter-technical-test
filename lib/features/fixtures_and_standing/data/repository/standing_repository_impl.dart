import '../../domain/entities/standing.dart';
import '../../domain/repository/standing_repository.dart';
import '../data_sources/remote/standing_service.dart';

// Define a class representing the implementation of the StandingRepository
class StandingRepositoryImpl implements StandingRepository {
  final StandingService _standingService;
  final int leagueId;
  final int season;

  StandingRepositoryImpl(
    this._standingService,
    this.leagueId,
    this.season,
  );

  // Implementation of the getStanding method from the StandingRepository interface
  @override
  Future<List<StandingEntity>> getStanding({int? leagueId, int? season}) async {
    try {
      // Call the service to get standing data
      final standing = await _standingService.getStanding(
          leagueId: leagueId ?? this.leagueId, season: season ?? this.season);
      return standing; // Return the fetched standing data
    } catch (e) {
      // Handle error as needed
      print('Error getting countries: $e');
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }
}
