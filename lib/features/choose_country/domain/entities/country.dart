import 'package:equatable/equatable.dart';

// CountryEntity represents an entity class for country info
class CountryEntity extends Equatable {
  final String? code; // Country code.
  final String? flag; // URL of country flag.
  final String? name; // Country name.

  // Constructor for the CountryEntity class
  const CountryEntity({
    this.code,
    this.flag,
    this.name,
  });

  // Override the props getter to make CountryEntity equatable
  @override
  List<Object?> get props {
    return [
      code,
      flag,
      name,
    ];
  }
}
