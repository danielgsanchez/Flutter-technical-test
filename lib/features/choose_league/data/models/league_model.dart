import '../../domain/entities/league.dart';

// Define a class representing the LeagueModel
class LeagueModel extends LeagueEntity {
  // Constructor of the superclass (LeagueEntity)
  const LeagueModel({
    super.id,
    super.name,
    super.type,
    super.logo,
    super.season,
    super.dateStarted,
    super.dateEnded,
    super.countryName,
    super.countryCode,
    super.countryFlag,
  });

  // Factory method to create a LeagueModel instance from a JSON map (transforms the JSON map from the API into a LeagueModel object)
  factory LeagueModel.fromJson(Map<String, dynamic> map) {
    List<dynamic> seasons = map['seasons'];
    Map<String, dynamic> latestSeason = seasons.last;
    return LeagueModel(
      id: map['league']['id'] ?? 0,
      name: map['league']['name'] ?? '',
      type: map['league']['type'] ?? '',
      logo: map['league']['logo'] ?? '',
      season: latestSeason['year'],
      dateStarted: DateTime.parse(latestSeason['start']),
      dateEnded: DateTime.parse(latestSeason['end']),
      countryName: map['country']['name'] ?? '',
      countryCode: map['country']['code'] ?? '',
      countryFlag: map['country']['flag'] ?? '',
    );
  }

  // Factory method to create a LeagueModel instance from a LeagueEntity instance
  factory LeagueModel.fromEntity(LeagueEntity entity) {
    return LeagueModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      logo: entity.logo,
      season: entity.season,
      dateStarted: entity.dateStarted,
      dateEnded: entity.dateEnded,
      countryName: entity.countryName,
      countryCode: entity.countryCode,
      countryFlag: entity.countryFlag,
    );
  }
}
