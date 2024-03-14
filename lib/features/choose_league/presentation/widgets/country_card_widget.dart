import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/league.dart';

// CountryCard Widget represents a card displaying information about a league's country
class CountryCard extends StatelessWidget {
  final LeagueEntity league;

  const CountryCard({
    super.key,
    required this.league,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SvgPicture.network(
                  // Displaying the country flag using SvgPicture from the network
                  league.countryFlag ?? '',
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  placeholderBuilder: (BuildContext context) {
                    return Container(
                      alignment: Alignment.center,
                      child:
                          const CircularProgressIndicator(), // Showing a circular progress indicator
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                league.countryName ?? '',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
