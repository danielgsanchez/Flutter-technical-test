import 'package:equatable/equatable.dart';

// Define a class representing a standing entity
class StandingEntity extends Equatable {
  // Define attributes for the standing entity.
  final int? rank; // The rank of the team.
  final Map<String, dynamic>? team; // Details about the team.
  final int? points; // The total points earned.
  final int? goalsDiff; // The goal difference.
  final String? group; // The group the team belongs to.
  final String? form; // The recent form of the team.
  final String? status; // The status of the standing.
  final Map<String, dynamic>? all; // All statistics.
  final Map<String, dynamic>? home; // Statistics for home matches.
  final Map<String, dynamic>? away; // Statistics for away matches.
  final String? update; // The last update time.

  // Constructor for the StandingEntity class
  const StandingEntity({
    this.rank,
    this.team,
    this.points,
    this.goalsDiff,
    this.group,
    this.form,
    this.status,
    this.all,
    this.home,
    this.away,
    this.update,
  });

  // Override the props getter to make StandingEntity equatable
  @override
  List<Object?> get props {
    return [
      rank,
      team,
      points,
      goalsDiff,
      group,
      form,
      status,
      all,
      home,
      away,
      update,
    ];
  }
}
