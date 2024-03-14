import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../fixtures_and_standing/presentation/pages/main_screen.dart';
import '../../domain/entities/league.dart';

// CompetitionCard Widget represents a card displaying information about a league competition
class CompetitionCard extends StatelessWidget {
  final LeagueEntity league;

  const CompetitionCard(
    this.league, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Creating a date formatter for displaying dates as YYYY/MM/DD instead of YYYY/MM/DD hh:mm:ss
    // * Maybe use intl to match user's device of displaying dates? *
    final dateFormat = DateFormat('yyyy/MM/dd');
    return Card(
      child: ListTile(
        // This will give the needed info to fetch fixtures and standing from a league and a season
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MainScreen(
              league: league.id!,
              season: league.season!,
            ),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(league.logo ?? ''),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          league.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${league.type ?? ''} - ${dateFormat.format(league.dateStarted ?? DateTime.now())} - ${dateFormat.format(league.dateEnded ?? DateTime.now())}',
        ),
      ),
    );
  }
}
