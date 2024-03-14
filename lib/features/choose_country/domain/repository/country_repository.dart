import '../entities/country.dart';

// CountryRepository is an abstract class representing the repository for countries.
abstract class CountryRepository {
  // Method to get countries.
  Future<List<CountryEntity>> getCountries();
}
