import '../../domain/entities/country.dart';
import '../../domain/repository/country_repository.dart';
import '../data_sources/remote/country_service.dart';

// CountryRepositoryImpl is an implementation of the CountryRepository interface.
class CountryRepositoryImpl implements CountryRepository {
  final CountryService _countryService;

  CountryRepositoryImpl(this._countryService);

  @override
  Future<List<CountryEntity>> getCountries() async {
    try {
      // Fetching countries from the CountryService
      final countries = await _countryService.getCountries();
      return countries; // Returning the fetched countries
    } catch (e) {
      // Handle error as needed
      print('Error getting countries: $e');
      rethrow; // Rethrow the error to be handled elsewhere
    }
  }
}
