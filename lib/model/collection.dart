import 'package:funsplash/model/photo.dart';
import 'package:funsplash/model/user.dart';

class Collection {
  final int id;
  final String title;
  final String description;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final bool curated;
  final int totalPhotos;
  final bool private;
  final String shareKey;
  final Photo coverPhoto;
  final User user;
  final Links links;

  const Collection(
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.updatedAt,
    this.curated,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.coverPhoto,
    this.user,
    this.links,
  );

  static fromJson(json) => Collection(
        json['id'],
        json['title'],
        json['description'],
        DateTime.parse(json['published_at']),
        DateTime.parse(json['updated_at']),
        json['curated'],
        json['total_photos'],
        json['private'],
        json['shareKey'],
        json['cover_photo'] != null ? Photo.fromJson(json['cover_photo']) : null,
        User.fromJson(json['user']),
        Links.fromJson(json['links']),
      );
}

class Links {
  final String self;
  final String html;
  final String photos;
  final String related;

  const Links(this.self, this.html, this.photos, this.related);

  static fromJson(json) => Links(
        json['self'],
        json['html'],
        json['photos'],
        json['related'],
      );
}
