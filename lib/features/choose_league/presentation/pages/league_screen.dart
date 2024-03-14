import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/remote/league_service.dart';
import '../../data/models/league_model.dart';
import '../../data/repository/league_repository_impl.dart';
import '../../domain/usecases/get_leagues_usecase.dart';
import '../bloc/load_league_cubit.dart';
import '../widgets/competition_card_widget.dart';
import '../widgets/country_card_widget.dart';

// LeagueScreen is a StatefulWidget representing the screen displaying leagues of a country
class LeagueScreen extends StatefulWidget {
  final String country;

  const LeagueScreen({
    super.key,
    required this.country,
  });

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  late final LoadLeaguesCubit _loadLeaguesCubit;

  @override
  void initState() {
    super.initState();
    // Initializing LoadLeaguesCubit
    _loadLeaguesCubit = LoadLeaguesCubit(
      GetLeagueUseCase(
        LeagueRepositoryImpl(
          LeagueService(),
          widget.country,
        ),
      ),
    );
    _loadLeaguesCubit.loadLeagues(widget.country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leagues'),
      ),
      body: SafeArea(
        child: BlocBuilder<LoadLeaguesCubit, LeaguesState>(
          bloc: _loadLeaguesCubit,
          builder: (context, state) {
            // Handling different states of the LoadLeaguesCubit.
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              final leagues = state.leagues;
              if (leagues.isEmpty) {
                return const Center(
                  child:
                      Text("No leagues information available in this country"),
                );
              } else {
                return ListView.builder(
                  itemCount: leagues.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CountryCard(
                        league: leagues.firstWhere(
                          (element) => element.countryCode == widget.country,
                          orElse: () => const LeagueModel(),
                        ),
                      );
                    } else {
                      final league = leagues[index - 1];
                      return CompetitionCard(league);
                    }
                  },
                );
              }
            } else {
              // Displaying error message and retry button if an error occurs.
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error loading leagues"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _loadLeaguesCubit.loadLeagues(widget.country);
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
