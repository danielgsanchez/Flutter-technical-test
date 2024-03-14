import '../../domain/entities/league.dart';
import '../../domain/repository/league_repository.dart';
import '../data_sources/remote/league_service.dart';

// LeagueRepositoryImpl is an implementation of the LeagueRepository interface.
class LeagueRepositoryImpl implements LeagueRepository {
  final LeagueService _leagueService;
  final String countryCode;

  LeagueRepositoryImpl(this._leagueService, this.countryCode);

  @override
  Future<List<LeagueEntity>> getLeagues({String? countryCode}) async {
    try {
      // Fetching leagues from the LeagueService.
      final leagues = await _leagueService.getLeagues(
          countryCode: countryCode ?? this.countryCode);
      return leagues; // Returning the fetched leagues.
    } catch (e) {
      // Handle error as needed
      print('Error getting countries: $e');
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }
}
