import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../data/models/standing_model.dart';
import '../../../domain/entities/standing.dart';
import '/../core/constants/constants.dart';

// Service class responsible for fetching standings data from the API
class StandingService {
  final Dio _dio = Dio();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // Retrieves standing data from the API based on league ID and season -> returns a list of [StandingEntity]
  // It'll check if a cached version is available, if not, it'll make the request to the API
  // * We could make the cache expirable so it will fetch from the API if more than X time has passed
  Future<List<StandingEntity>> getStanding({int? leagueId, int? season}) async {
    try {
      final cachedData = await _cacheManager.getFileFromCache(
          '$apiBaseURL/v3/standings?league=$leagueId&season=$season');
      if (cachedData != null && cachedData.file != null) {
        final cachedJson = await cachedData.file!.readAsString();
        final cachedDataMap = json.decode(cachedJson);
        final List<dynamic> responseData =
            cachedDataMap['response'][0]['league']['standings'] != null
                ? cachedDataMap['response'][0]['league']['standings']
                : [];
        final List<StandingEntity> standings = [];
        for (final List<dynamic> standingsList in responseData) {
          final List<StandingEntity> standingList = standingsList
              .map((json) => StandingModel.fromJson(json))
              .toList();
          standings.addAll(standingList);
        }
        return standings;
      }

      final response = await _dio.get('$apiBaseURL/v3/standings',
          queryParameters: {
            'league': leagueId!,
            'season': season!,
          },
          options: Options(headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          }));

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            response.data['response'][0]['league']['standings'];
        final List<StandingEntity> standings = [];
        for (final List<dynamic> standingsList in responseData) {
          final List<StandingEntity> standingList = standingsList
              .map((json) => StandingModel.fromJson(json))
              .toList();
          standings.addAll(standingList);
        }
        await _cacheManager.putFile(
            '$apiBaseURL/v3/standings?league=$leagueId&season=$season',
            utf8.encode(json.encode({'response': response.data['response']})));
        return standings;
      } else {
        throw DioException(
            response: response,
            requestOptions: RequestOptions(path: '$apiBaseURL/v3/standings'),
            error: 'Failed to load standings');
      }
    } catch (e) {
      throw DioException(
          error: 'Error: $e',
          requestOptions: RequestOptions(path: '$apiBaseURL/v3/standings'));
    }
  }
}
