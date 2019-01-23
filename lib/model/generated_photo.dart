import 'dart:convert' show json;
import 'package:funsplash/model/photo.dart';

class GeneratedPhoto {
  int total;
  int totalPages;
  List<Photo> results;

  GeneratedPhoto.fromParams({this.total, this.totalPages, this.results});

  factory GeneratedPhoto(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new GeneratedPhoto.fromJson(json.decode(jsonStr))
          : new GeneratedPhoto.fromJson(jsonStr);

  GeneratedPhoto.fromJson(jsonRes) {
    total = jsonRes['total'];
    totalPages = jsonRes['total_pages'];
    results = jsonRes['results'] == null ? null : [];

    for (var resultsItem in results == null ? [] : jsonRes['results']) {
      results.add(resultsItem == null ? null : Photo.fromJson(resultsItem));
    }
  }

  @override
  String toString() {
    return '{"total": $total,"total_pages": $totalPages,"results": $results}';
  }
}
