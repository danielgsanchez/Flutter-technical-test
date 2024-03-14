import 'package:equatable/equatable.dart';

// LeagueEntity represents an entity class for league information.
class LeagueEntity extends Equatable {
  final int? id; // League ID.
  final String? name; // League name.
  final String? type; // Type of league.
  final String? logo; // URL of league logo.
  final int? season; // Current season of the league.
  final DateTime? dateStarted; // Date when the league started.
  final DateTime? dateEnded; // Date when the league ended.
  final String? countryName; // Name of the country hosting the league.
  final String? countryCode; // Code of the country hosting the league.
  final String? countryFlag; // URL of the country's flag.

  // Constructor for the LeagueEntity class.
  const LeagueEntity({
    this.id,
    this.name,
    this.type,
    this.logo,
    this.season,
    this.dateStarted,
    this.dateEnded,
    this.countryName,
    this.countryCode,
    this.countryFlag,
  });

  // Override the props getter to make LeagueEntity equatable
  @override
  List<Object?> get props {
    return [
      id,
      name,
      type,
      logo,
      season,
      dateStarted,
      dateEnded,
      countryName,
      countryCode,
      countryFlag,
    ];
  }
}
