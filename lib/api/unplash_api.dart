import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:funsplash/model/collection.dart';
import 'package:funsplash/model/photo.dart';
import 'package:funsplash/api/api_key.dart';
import 'package:funsplash/model/categories.dart';

class UnsplashApi {
  static const baseUrl = 'https://api.unsplash.com';
  static const headers = {
    'Authorization': "Client-ID ${AccessKey.unsplashAccessKey}",
    'Accept-Version': 'v1'
  };

  Future<List<Photo>> getLatestPhotos({page: 1, perPage: 10}) async {
    //get the latest photos
    final Response response = await get(
        "$baseUrl/photos?page=$page&per_page=$perPage",
        headers: headers);
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<List<Photo>> getPopularPhotos({page: 1, perPage: 10}) async {
    //get the popular photos
    final Response response = await get(
        "$baseUrl/photos?page=$page&per_page=$perPage&order_by=popular",
        headers: headers);
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<List<Photo>> getCuratedPhotos({page: 1, perPage: 10}) async {
    //get the curated photos
    final Response response = await get(
        "$baseUrl/photos/curated?page=$page&per_page=$perPage",
        headers: headers);
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<List<Photo>> getRandomPhotos({count: 20}) async {
    //get the random photos
    final Response response =
        await get("$baseUrl/photos/random?count=$count", headers: headers);
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<List<Collection>> getCollections({page: 1, perPage: 10}) async {
    final Response response = await get(
      "$baseUrl/collections?page=$page&per_page=$perPage",
      headers: headers,
    );
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody
        .map<Collection>((json) => Collection.fromJson(json))
        .toList();
  }

  Future<List<Photo>> getPhotosByCollections(Collection collection,
      [page = 1, perPage = 10]) async {
    final Response response = await get(
      "$baseUrl/collections/${collection.id}/photos?page=$page&per_page=$perPage",
      headers: headers,
    );
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<GeneratedCategory> getPhotosBySearch(
      {String searchContext, page: 1, perPage: 10}) async {
    final Response response = await get(
      "$baseUrl/search/photos?page=$page&per_page=$perPage&query=$searchContext",
      headers: headers,
    );
    final decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return GeneratedCategory.fromJson(decodedBody);
  }

  Future<List<Collection>> getFeaturedCollections(
      {page: 1, perPage: 10}) async {
    final Response response = await get(
      "$baseUrl/collections/featured?page=$page&per_page=$perPage",
      headers: headers,
    );
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody
        .map<Collection>((json) => Collection.fromJson(json))
        .toList();
  }

  Future<List<Collection>> getCuratedCollections({perPage: 10}) async {
    final Response response = await get(
      "$baseUrl/collections/curated?per_page=$perPage",
      headers: headers,
    );
    final List decodedBody = json.decode(utf8.decode(response.bodyBytes));
    return decodedBody
        .map<Collection>((json) => Collection.fromJson(json))
        .toList();
  }
}
