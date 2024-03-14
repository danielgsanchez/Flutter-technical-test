import 'package:flutter/material.dart';

import '../../domain/entities/fixture.dart';

// A widget that displays a list of fixtures
class FixtureListWidget extends StatelessWidget {
  // The list of fixture entities to display
  final List<FixtureEntity> fixtures;

  const FixtureListWidget({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: fixtures.length,
        itemBuilder: (context, index) {
          FixtureEntity fixture = fixtures[index];
          return Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    fixture.venueName ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(fixture.homeTeamLogo ?? '',
                          width: 45, height: 45),
                      Text(
                        '${fixture.goalsHome ?? 0} - ${fixture.goalsAway ?? 0}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Image.network(fixture.awayTeamLogo ?? '',
                          width: 45, height: 45),
                    ],
                  ),
                  Text(
                    '${fixture.statusShort ?? ''} ${fixture.statusElapsed ?? 0}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
