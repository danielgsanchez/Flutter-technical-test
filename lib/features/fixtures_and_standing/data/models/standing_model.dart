import '../../domain/entities/standing.dart';

// Define a class representing the StandingModel
class StandingModel extends StandingEntity {
  // Constructor of the superclass (StandingEntity)
  const StandingModel({
    super.rank,
    super.team,
    super.points,
    super.goalsDiff,
    super.group,
    super.form,
    super.status,
    super.all,
    super.home,
    super.away,
    super.update,
  });

  // Factory method to create a StandingModel instance from a JSON map (transforms the JSON map from the API into a StandingModel object)
  factory StandingModel.fromJson(Map<String, dynamic> map) {
    return StandingModel(
      rank: map['rank'] as int,
      team: map['team'] as Map<String, dynamic>,
      points: map['points'] as int,
      goalsDiff: map['goalsDiff'] as int,
      group: map['group'] as String,
      form: map['form'] as String,
      status: map['status'] as String,
      all: map['all'] as Map<String, dynamic>,
      home: map['home'] as Map<String, dynamic>,
      away: map['away'] as Map<String, dynamic>,
      update: map['update'] as String,
    );
  }

  // Factory method to create a StandingModel instance from a StandingEntity instance
  factory StandingModel.fromEntity(StandingEntity entity) {
    return StandingModel(
      rank: entity.rank,
      team: entity.team,
      points: entity.points,
      goalsDiff: entity.goalsDiff,
      group: entity.group,
      form: entity.form,
      status: entity.status,
      all: entity.all,
      home: entity.home,
      away: entity.away,
      update: entity.update,
    );
  }
}
