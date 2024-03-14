import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/remote/standing_service.dart';
import '../../data/repository/standing_repository_impl.dart';
import '../../domain/usecases/get_standing_usecase.dart';
import '../bloc/load_standing_cubit.dart';
import '../widgets/standing_table_widget.dart';

// A screen widget that displays standings for a given league and season
class StandingScreen extends StatefulWidget {
  // The ID of the league (we'll get this from main_screen.dart navigation)
  final int? league;
  // The season of the standings
  final int? season;

  const StandingScreen({super.key, required this.league, required this.season});

  @override
  State<StandingScreen> createState() => _StandingScreenState();
}

class _StandingScreenState extends State<StandingScreen> {
  late final LoadStandingCubit _loadStandingCubit;

  //We initialize the cubits here
  @override
  void initState() {
    super.initState();
    _loadStandingCubit = LoadStandingCubit(
      GetStandingUseCase(
        StandingRepositoryImpl(
          StandingService(),
          widget.league!,
          widget.season!,
        ),
      ),
    );
    _loadStandingCubit.loadStanding(widget.league!, widget.season!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadStandingCubit, StandingStates>(
      bloc: _loadStandingCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          return StandingTableWidget(standings: state.standing);
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Error loading standing"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _loadStandingCubit.loadStanding(
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
