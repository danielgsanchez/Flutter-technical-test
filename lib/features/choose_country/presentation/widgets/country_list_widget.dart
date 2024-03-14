import 'package:flutter/material.dart';

import '../../../choose_league/presentation/pages/league_screen.dart';
import '../../domain/entities/country.dart';
import 'flag_image_widget.dart';

// CountryList Widget represents a list of countries.
class CountryList extends StatelessWidget {
  final List<CountryEntity> filteredCountries;

  const CountryList({super.key, required this.filteredCountries});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: filteredCountries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      // Passing country code to the LeagueScreen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LeagueScreen(
                            country: country.code!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FlagImage(
                            country: country,
                            width: 40,
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              country.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
