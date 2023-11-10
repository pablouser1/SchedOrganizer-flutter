import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:schedorganizer/common.dart';
import 'package:schedorganizer/models/apires.dart';
import 'package:schedorganizer/models/schedule.dart';

class Api {
  final http.Client _client = http.Client();

  Future<ApiRes<List<Schedule>>> getClosestSchedules() async {
    final json = await _makeRequest("/schedules/closest");

    return ApiRes.fromJson(json, (data) {
      Iterable l = data;
      List<Schedule> schedules =
          List<Schedule>.from(l.map((model) => Schedule.fromJson(model)));
      return schedules;
    });
  }

  Future<ApiRes<List<Schedule>>> getSchedulesByWeekday(int weekday) async {
    final json = await _makeRequest("/schedules/weekdays/$weekday");

    return ApiRes.fromJson(json, (data) {
      Iterable l = data;
      List<Schedule> schedules =
          List<Schedule>.from(l.map((model) => Schedule.fromJson(model)));
      return schedules;
    });
  }

  dynamic _makeRequest(String endpoint) async {
    final url = await _getBaseUrl(endpoint);
    final res = await _client.get(url);

    if (res.headers.containsKey("content-type") &&
        res.headers['content-type'] == "application/json") {
      final json = convert.jsonDecode(res.body);
      return json;
    }

    throw Exception("Invalid response type");
  }

  Future<Uri> _getBaseUrl<T>(String path) async {
    final baseUrl = "${await config.getBaseUrl()}/api/v1$path";
    try {
      final url = Uri.parse(baseUrl);
      return url;
    } on FormatException {
      throw Exception("Invalid URL, maybe you haven't set your base URL?");
    }
  }
}
