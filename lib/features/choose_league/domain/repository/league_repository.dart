import '../../domain/entities/league.dart';

// LeagueRepository is an abstract class representing the repository for leagues
abstract class LeagueRepository {
  // Method to get leagues for a specific country
  Future<List<LeagueEntity>> getLeagues({String? countryCode});
}
