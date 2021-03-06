import 'package:funsplash/model/user.dart';

class Photo {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int width;
  final int height;
  final int likes;
  final int downloads;
  final int views;
  final String color;
  final String description;
  final Urls urls;
  final User user;
  // final Exif exif;

  const Photo(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.urls,
    this.user,
    this.likes,
    this.downloads,
    this.views,
    // this.exif,
  );

  static fromJson(json) => Photo(
        json['id'],
        DateTime.parse(json['created_at']),
        DateTime.parse(json['updated_at']),
        json['width'],
        json['height'],
        json['color'],
        json['description'],
        Urls.fromJson(json['urls']),
        User.fromJson(json['user']),
        json['likes'],
        json['downloads'],
        json['views'],
        
        // json['exif'] != null ? Exif.fromJson(json['exif']) : null,
      );
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  const Urls(this.raw, this.full, this.regular, this.small, this.thumb);

  static fromJson(json) => Urls(
        json['raw'],
        json['full'],
        json['regular'],
        json['small'],
        json['thumb'],
      );
}

// class Exif {
//   final String make;
//   final String model;
//   final String exposureTime;
//   final String aperture;
//   final String focalLength;
//   final int iso;

//   const Exif(this.make, this.model, this.exposureTime, this.aperture,
//       this.focalLength, this.iso);

//   static fromJson(json) => Exif(
//         json['make'],
//         json['model'],
//         json['exposure_time'],
//         json['aperture'],
//         json['focal_length'],
//         json['iso'],
//       );
// }
