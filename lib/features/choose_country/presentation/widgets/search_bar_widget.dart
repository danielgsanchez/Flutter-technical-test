import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchTextChanged;

  const SearchBar(
      {super.key,
      required this.searchController,
      required this.onSearchTextChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onSearchTextChanged,
      decoration: InputDecoration(
        hintText: 'Pick the country you want stats from',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
