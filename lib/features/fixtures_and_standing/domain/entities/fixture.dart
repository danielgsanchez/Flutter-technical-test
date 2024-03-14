import 'package:equatable/equatable.dart';

// Define a class representing a fixture entity
class FixtureEntity extends Equatable {
  // Define attributes for the fixture entity
  final int? id; // Fixture ID.
  final String? referee; // Referee name.
  final String? timezone; // Timezone.
  final String? date; // Date of the fixture.
  final int? timestamp; // Timestamp of the fixture.
  final int? venueId; // Venue ID.
  final String? venueName; // Venue name.
  final String? venueCity; // Venue city.
  final String? statusLong; // Long status of the fixture.
  final String? statusShort; // Short status of the fixture.
  final int? statusElapsed; // Elapsed status of the fixture.
  final int? leagueId; // League ID.
  final String? leagueName; // League name.
  final String? leagueCountry; // League country.
  final String? leagueLogo; // League logo URL.
  final String? leagueFlag; // League flag URL.
  final int? leagueSeason; // League season.
  final String? leagueRound; // League round.
  final int? homeTeamId; // Home team ID.
  final String? homeTeamName; // Home team name.
  final String? homeTeamLogo; // Home team logo URL.
  final bool? homeTeamWinner; // Whether the home team is the winner.
  final int? awayTeamId; // Away team ID.
  final String? awayTeamName; // Away team name.
  final String? awayTeamLogo; // Away team logo URL.
  final bool? awayTeamWinner; // Whether the away team is the winner.
  final int? goalsHome; // Goals scored by the home team.
  final int? goalsAway; // Goals scored by the away team.
  final int? scoreHalftimeHome; // Halftime score of the home team.
  final int? scoreHalftimeAway; // Halftime score of the away team.
  final int? scoreFulltimeHome; // Fulltime score of the home team.
  final int? scoreFulltimeAway; // Fulltime score of the away team.
  final int? scoreExtratimeHome; // Extratime score of the home team.
  final int? scoreExtratimeAway; // Extratime score of the away team.
  final int? scorePenaltyHome; // Penalty score of the home team.
  final int? scorePenaltyAway; // Penalty score of the away team.

  // Constructor for the FixtureEntity class
  const FixtureEntity({
    this.id,
    this.referee,
    this.timezone,
    this.date,
    this.timestamp,
    this.venueId,
    this.venueName,
    this.venueCity,
    this.statusLong,
    this.statusShort,
    this.statusElapsed,
    this.leagueId,
    this.leagueName,
    this.leagueCountry,
    this.leagueLogo,
    this.leagueFlag,
    this.leagueSeason,
    this.leagueRound,
    this.homeTeamId,
    this.homeTeamName,
    this.homeTeamLogo,
    this.homeTeamWinner,
    this.awayTeamId,
    this.awayTeamName,
    this.awayTeamLogo,
    this.awayTeamWinner,
    this.goalsHome,
    this.goalsAway,
    this.scoreHalftimeHome,
    this.scoreHalftimeAway,
    this.scoreFulltimeHome,
    this.scoreFulltimeAway,
    this.scoreExtratimeHome,
    this.scoreExtratimeAway,
    this.scorePenaltyHome,
    this.scorePenaltyAway,
  });

  // Override the props getter to make FixtureEntity equatable
  @override
  List<Object?> get props {
    return [
      id,
      referee,
      timezone,
      date,
      timestamp,
      venueId,
      venueName,
      venueCity,
      statusLong,
      statusShort,
      statusElapsed,
      leagueId,
      leagueName,
      leagueCountry,
      leagueLogo,
      leagueFlag,
      leagueSeason,
      leagueRound,
      homeTeamId,
      homeTeamName,
      homeTeamLogo,
      homeTeamWinner,
      awayTeamId,
      awayTeamName,
      awayTeamLogo,
      awayTeamWinner,
      goalsHome,
      goalsAway,
      scoreHalftimeHome,
      scoreHalftimeAway,
      scoreFulltimeHome,
      scoreFulltimeAway,
      scoreExtratimeHome,
      scoreExtratimeAway,
      scorePenaltyHome,
      scorePenaltyAway,
    ];
  }
}
