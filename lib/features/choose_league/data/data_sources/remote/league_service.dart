import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../domain/entities/league.dart';
import '../../models/league_model.dart';
import '/../core/constants/constants.dart';

class LeagueService {
  final Dio _dio = Dio();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  Future<List<LeagueEntity>> getLeagues({String? countryCode}) async {
    try {
      final cachedData = await _cacheManager.getFileFromCache(
          '$apiBaseURL/v3/leagues?code=$countryCode&current=true');
      if (cachedData != null && cachedData.file != null) {
        final cachedJson = await cachedData.file!.readAsString();
        final cachedDataMap = json.decode(cachedJson);
        final List<dynamic> responseData =
            cachedDataMap['response'] != null ? cachedDataMap['response'] : [];
        final List<LeagueEntity> leagues =
            responseData.map((json) => LeagueModel.fromJson(json)).toList();
        return leagues;
      }

      final response = await _dio.get('$apiBaseURL/v3/leagues',
          queryParameters: {'code': countryCode, 'current': true},
          options: Options(headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          }));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['response'];
        final List<LeagueEntity> leagues =
            responseData.map((json) => LeagueModel.fromJson(json)).toList();
        await _cacheManager.putFile(
            '$apiBaseURL/v3/leagues?code=$countryCode&current=true',
            utf8.encode(json.encode({'response': responseData})));
        return leagues;
      } else {
        throw DioException(
            response: response,
            requestOptions: RequestOptions(path: '$apiBaseURL/v3/leagues'),
            error: 'Failed to load leagues');
      }
    } catch (e) {
      throw DioException(
          error: 'Error: $e',
          requestOptions: RequestOptions(path: '$apiBaseURL/v3/leagues'));
    }
  }
}
