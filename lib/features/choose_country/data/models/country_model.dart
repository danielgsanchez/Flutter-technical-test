import '../../domain/entities/country.dart';

// Define a class representing the CountryModel
class CountryModel extends CountryEntity {
  const CountryModel({
    super.code,
    super.flag,
    super.name,
  });

  // Factory method to create a CountryModel instance from a JSON map (transforms the JSON map from the API into a CountryModel object)
  factory CountryModel.fromJson(Map<String, dynamic> map) {
    return CountryModel(
      code: map['code'] ?? '',
      flag: map['flag'] ?? '',
      name: map['name'] ?? '',
    );
  }

  // Factory method to create a CountryModel instance from a CountryEnitty instance
  factory CountryModel.fromEntity(CountryEntity entity) {
    return CountryModel(
      code: entity.code,
      flag: entity.flag,
      name: entity.name,
    );
  }
}
