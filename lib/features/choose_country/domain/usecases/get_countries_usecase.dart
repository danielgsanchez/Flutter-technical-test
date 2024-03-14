import '../entities/country.dart';
import '../repository/country_repository.dart';

// GetCountryUseCase represents the use case for getting countries
class GetCountryUseCase {
  final CountryRepository _countryRepository;

  GetCountryUseCase(this._countryRepository);

  // Method to get countries
  Future<List<CountryEntity>> call({void params}) {
    return _countryRepository
        .getCountries(); // Calling the method from the repository
  }
}
