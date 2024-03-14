import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/remote/fixture_service.dart';
import '../../data/repository/fixture_repository_impl.dart';
import '../../domain/usecases/get_fixtures_usecase.dart';
import '../bloc/load_fixtures_cubit.dart';
import '../widgets/fixture_list_widget.dart';

// A screen widget to display fixtures for a specific league and season
class FixtureScreen extends StatefulWidget {
  // The ID of the league
  final int? league;
  // The season of the fixtures
  final int? season;

  const FixtureScreen({super.key, required this.league, required this.season});

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  late final LoadFixturesCubit _loadFixturesCubit;

  // Initialize the LoadFixturesCubit.
  @override
  void initState() {
    super.initState();
    _loadFixturesCubit = LoadFixturesCubit(
      GetFixtureUseCase(
        FixtureRepositoryImpl(
          FixtureService(),
          widget.league!,
          widget.season!,
        ),
      ),
    );
    _loadFixturesCubit.loadFixtures(widget.league!, widget.season!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadFixturesCubit, FixturesState>(
      bloc: _loadFixturesCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          return FixtureListWidget(fixtures: state.fixtures);
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error loading fixtures"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _loadFixturesCubit.loadFixtures(
                        widget.league!, widget.season!);
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
