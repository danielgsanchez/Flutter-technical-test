import '../../domain/repository/country_repository.dart';
import '../entities/country.dart';

class SearchCountriesUseCase {
  final CountryRepository _countryRepository;

  SearchCountriesUseCase(this._countryRepository);

  Future<List<CountryEntity>> execute(String query) async {
    final countries = await _countryRepository.getCountries();
    return countries.where((country) {
      if (country.name != null && country.code != null) {
        // Search by name (also finds partial findings)
        if (country.name!.toLowerCase().contains(query.toLowerCase())) {
          return true;
        }
        // Search by code (you have to use "" and uppercase - ex: "ES", "AL" for Spain and Albania)
        if (query.startsWith('"') && query.endsWith('"')) {
          final code = query.substring(1, query.length - 1);
          return country.code!.toUpperCase() == code.toUpperCase();
        }
      }
      return false;
    }).toList();
  }
}
