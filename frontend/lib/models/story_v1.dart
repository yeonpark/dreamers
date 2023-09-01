import 'dart:convert';
// import 'dart:io';

class Story {
  //final int id;
  //final bool isAdmin;
  final String heading;
  final String sub_heading;
  final String country;
  final String summary;
  final String full_detail;
  // final List<File> images;
  final String category;

  // Below needs to be deleted
  final String schema;
  final int month_cnt;
  final int monthly_stipend;

  Story({
    required this.heading,
    required this.sub_heading,
    required this.country,
    required this.summary,
    required this.full_detail,
    required this.category,
    // required this.images,
    ////required this.id,
    //required this.isAdmin,

    // Below needs to be deleted
    required this.schema,
    required this.month_cnt,
    required this.monthly_stipend,
  });

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      //'isAdmin': isAdmin,
      'heading': heading,
      'sub_heading': sub_heading,
      'country': country,
      'summary': summary,
      'full_detail': full_detail,
      'category': category,
      // 'images': images,

      // Below needs to be deleted
      'schema': schema,
      'month_cnt': month_cnt,
      'monthly_stipend': monthly_stipend,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      //isAdmin: map['is_admin'] ?? false,
      //id: map['_id'] ?? -1,
      heading: map['heading'] ?? '',
      sub_heading: map['sub_heading'] ?? '',
      country: map['country'] ?? '',
      summary: map['summary'] ?? '',
      full_detail: map['full_detail'] ?? '',
      category: map['category'] ?? '',
      // images: List<File>.from(map['images']),

      // Below needs to be deleted
      schema: map['schema'] ?? '',
      month_cnt: map['month_cnt'] ?? 1,
      monthly_stipend: map['monthly_stipend'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  Story copyWith({
    //int? id,
    //bool? isAdmin,
    String? heading,
    String? sub_heading,
    String? country,
    String? summary,
    String? full_detail,
    String? category,
    // List<File>? images,

    // Below needs to be deleted
    String? schema,
    int? month_cnt,
    int? monthly_stipend,
  }) {
    return Story(
      //id: id ?? this.id,
      //isAdmin: isAdmin ?? this.isAdmin,
      heading: heading ?? this.heading,
      sub_heading: sub_heading ?? this.sub_heading,
      country: country ?? this.country,
      summary: summary ?? this.summary,
      full_detail: full_detail ?? this.full_detail,
      category: category ?? this.category,
      // images: images ?? this.images,

      // Below needs to be deleted
      schema: schema ?? this.schema,
      month_cnt: month_cnt ?? this.month_cnt,
      monthly_stipend: monthly_stipend ?? this.monthly_stipend,
    );
  }
}
