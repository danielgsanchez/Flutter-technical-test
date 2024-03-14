import 'package:flutter/material.dart';

import 'fixtures_screen.dart';
import 'standing_screen.dart';

// A widget representing the main screen of the app, containing fixtures and standings
class MainScreen extends StatefulWidget {
  // We get these parameters from the previous screen navigator
  // The ID of the league
  final int? league;
  // The season of the fixtures and standings
  final int? season;

  const MainScreen({
    super.key,
    required this.league,
    required this.season,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Fixtures' : 'Standing'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_rounded),
            label: 'Fixtures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart_rounded),
            label: 'Standing',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Builds the body of the main screen based on the selected index (Fixtures/Standing using the same two parameters)
  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return FixtureScreen(league: widget.league, season: widget.season);
    } else {
      return StandingScreen(league: widget.league, season: widget.season);
    }
  }

  // Handles the tap event on the bottom navigation bar items ** (maybe can be moved to a cubit? but not really worth) **
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
