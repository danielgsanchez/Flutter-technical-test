import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/country.dart';
import '../../models/country_model.dart';

// CountryService class is responsible for fetching country data from an API.
class CountryService {
  final Dio _dio = Dio();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // Method to fetch countries.
  Future<List<CountryEntity>> getCountries() async {
    try {
      // Check if data is cached.
      final cachedData =
          await _cacheManager.getFileFromCache('$apiBaseURL/v3/countries');
      if (cachedData != null && cachedData.file != null) {
        // This will scream that is not needed but trust me we need this
        final cachedJson = await cachedData.file.readAsString();
        final List<dynamic> responseData =
            cachedJson.isNotEmpty ? json.decode(cachedJson)['response'] : [];
        final List<CountryEntity> countries = responseData
            .map((e) => CountryModel.fromJson(e))
            .where((country) => country.name != 'World')
            .toList();
        return countries;
      }

      // Fetch data from API.
      final response = await _dio.get('$apiBaseURL/v3/countries',
          options: Options(headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          }));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['response'];
        final List<CountryEntity> countries = responseData
            .map((e) => CountryModel.fromJson(e))
            .where((country) => country.name != 'World')
            .toList();
        // Cache the response.
        await _cacheManager.putFile('$apiBaseURL/v3/countries',
            utf8.encode(json.encode(response.data)));
        return countries;
      } else {
        throw DioException(
            response: response,
            requestOptions: RequestOptions(path: '$apiBaseURL/v3/countries'),
            error: 'Failed to load countries');
      }
    } catch (e) {
      throw DioException(
          error: 'Error: $e',
          requestOptions: RequestOptions(path: '$apiBaseURL/v3/countries'));
    }
  }
}
