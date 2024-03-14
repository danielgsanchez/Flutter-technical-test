import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../data/models/fixture_model.dart';
import '../../../domain/entities/fixture.dart';
import '/../core/constants/constants.dart';

// Service class responsible for fetching fixtures data from the API
class FixtureService {
  final Dio _dio = Dio();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // Retrieves standing data from the API based on league ID and season -> returns a list of [FixtureEntity]
  // It'll check if a cached version is available, if not, it'll make the request to the API
  // * We could make the cache expirable so it will fetch from the API if more than X time has passed
  Future<List<FixtureEntity>> getFixtures({int? leagueId, int? season}) async {
    try {
      final cachedData = await _cacheManager.getFileFromCache(
          '$apiBaseURL/v3/fixtures?league=$leagueId&season=$season');
      if (cachedData != null && cachedData.file != null) {
        final cachedJson = await cachedData.file!.readAsString();
        final cachedDataMap = json.decode(cachedJson);
        final List<dynamic> responseData =
            cachedDataMap['response'] != null ? cachedDataMap['response'] : [];
        final List<FixtureEntity> fixtures =
            responseData.map((json) => FixtureModel.fromJson(json)).toList();
        return fixtures;
      }

      final response = await _dio.get('$apiBaseURL/v3/fixtures',
          queryParameters: {
            'league': leagueId,
            'season': season,
          },
          options: Options(headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          }));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['response'];
        final List<FixtureEntity> fixtures =
            responseData.map((json) => FixtureModel.fromJson(json)).toList();
        await _cacheManager.putFile(
            '$apiBaseURL/v3/fixtures?league=$leagueId&season=$season',
            utf8.encode(json.encode({'response': responseData})));
        return fixtures;
      } else {
        throw DioException(
            response: response,
            requestOptions: RequestOptions(path: '$apiBaseURL/v3/fixtures'),
            error: 'Failed to load fixtures');
      }
    } catch (e) {
      throw DioException(
          error: 'Error: $e',
          requestOptions: RequestOptions(path: '$apiBaseURL/v3/fixtures'));
    }
  }
}
