import 'package:flutter/material.dart';

import '../../domain/entities/standing.dart';

// A widget that displays a table of standings for the selected league
class StandingTableWidget extends StatelessWidget {
  // The list of standing entities to display in the table
  final List<StandingEntity> standings;

  const StandingTableWidget({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Team')),
              DataColumn(label: Text('MP')), // Matches Played
              DataColumn(label: Text('W')), // Wins
              DataColumn(label: Text('D')), // Draws
              DataColumn(label: Text('L')), // Losses
              DataColumn(label: Text('GF')), // Goals For
              DataColumn(label: Text('GA')), // Goals Against
              DataColumn(label: Text('GD')), // Goal Difference
              DataColumn(label: Text('Pts')), // Points
              DataColumn(label: Text('Last five matches')), // Form
            ],
            rows: standings.map((standing) {
              return DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        standing.team != null && standing.team!['logo'] != null
                            ? Image.network(
                                standing.team!['logo'],
                                width: 30,
                                height: 30,
                              )
                            : Container(),
                        const SizedBox(width: 8),
                        Text(standing.team?['name'] ?? ''),
                      ],
                    ),
                  ),
                  DataCell(Text('${standing.all!['played'] ?? 0}')),
                  DataCell(Text('${standing.all!['win'] ?? 0}')),
                  DataCell(Text('${standing.all!['draw'] ?? 0}')),
                  DataCell(Text('${standing.all!['lose'] ?? 0}')),
                  DataCell(Text('${standing.all!['goals']['for'] ?? 0}')),
                  DataCell(Text('${standing.all!['goals']['against'] ?? 0}')),
                  DataCell(Text('${standing.goalsDiff ?? 0}')),
                  DataCell(Text('${standing.points ?? 0}')),
                  DataCell(
                    Row(
                      children: [_buildFormWidget(standing.form)],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Builds a widget to display the form of the team in the last five matches
  Widget _buildFormWidget(String? form) {
    if (form == null || form.isEmpty) {
      return Container();
    }
    return Row(
      children: form.split('').map((result) {
        return Container(
          margin: const EdgeInsets.only(right: 5),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: result == 'W'
                ? Colors.green
                : (result == 'D' ? Colors.blue : Colors.red),
          ),
          child: Center(
            child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
