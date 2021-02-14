import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class ApiInterface {
  Future<String> getNextLaunch();
  Future<String> getUpcomingLaunches();
}

class DataService implements ApiInterface {
  static const classTag = 'ApiService';
  static DataService _singleton;
  http.Client httpClient;
  String apiEndpoint;
  bool isInitialised = false;

  factory DataService(http.Client httpClient, {@required String endPoint}) {
    assert(endPoint != null);
    _singleton ??= DataService._internal(
      httpClient,
      endPoint,
    );
    return _singleton;
  }

  DataService._internal(
    http.Client _httpClient,
    String _endPoint,
  ) {
    apiEndpoint = _endPoint;
    httpClient = _httpClient;
  }

  @override
  Future<String> getNextLaunch() async {
    const tag = 'getNextLaunch()';
    String request;
    http.Response response;

    // todo should check connection here
    request = '$apiEndpoint/next/';

    try {
      response = await httpClient.get(request);
    } on Exception catch (ex) {
      debugPrint('$classTag.$tag Exception calling API : $ex');
      // API call not successful
    }

    if (_validApiResponse(response.statusCode)) {
      return response.body;
    } else {
      // bad response code
      var error = Exception('$classTag.$tag : $response.statusCode returned');
      throw error;
    }
  }

  @override
  Future<String> getUpcomingLaunches() async {
    const tag = 'getUpcomingLaunches()';
    String request;
    http.Response response;

    // todo should check data connection here
    request = '$apiEndpoint/upcoming/';

    try {
      response = await httpClient.get(request);
    } on Exception catch (ex) {
      debugPrint('$classTag.$tag Exception calling API : $ex');
      // API call not successful
    }

    if (_validApiResponse(response.statusCode)) {
      return response.body;
    } else {
      // bad response code
      var error = Exception('$classTag.$tag : $response.statusCode returned');
      throw error;
    }
  }

  bool _validApiResponse(int response) => response >= 200 && response <= 299;
}
