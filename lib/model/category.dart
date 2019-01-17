class Category {
  final int total;
  final int totalPages;
  final Results results;

  const Category(
    this.total,
    this.totalPages,
    this.results,
  );

  static fromJson(Map<String, dynamic> json) => Category(
        json['total'],
        json['total_pages'],
        Results.fromJson(json['results']),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'totalPages': totalPages,
        'results': results,
      };
}

class Results {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int width;
  final int height;
  final String color;
  final String description;
  final Urls urls;

  const Results(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.urls,
  );

  static fromJson(json) {
    return Results(
      json['id'],
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
      json['width'],
      json['height'],
      json['color'],
      json['description'],
      Urls.fromJson(json['urls']),
    );
  }
}

//   static fromJson(json) => Results(
//         json['id'],
//         DateTime.parse(json['created_at']),
//         DateTime.parse(json['updated_at']),
//         json['width'],
//         json['height'],
//         json['color'],
//         json['description'],
//         Urls.fromJson(json['urls']),
//       );

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

class Links {
  final String self;
  final String html;
  final String download;
  final String downloadLocation;

  const Links(this.self, this.html, this.download, this.downloadLocation);

  static fromJson(json) => Links(
        json['self'],
        json['html'],
        json['download'],
        json['download_location'],
      );
}
