  class MyModel {
  final String id;
  final UserModel user;
  final String createdAt;
  final List<Category> category;
  final String heading;
  final String subHeading;
  final String full_detail;
  final String summary;
  final List<ImageModel> images;
  final String country;
  final bool isVerified;
  final SchemaModel schema;

  MyModel({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.category,
    required this.heading,
    required this.subHeading,
    required this.full_detail,
    required this.summary,
    required this.images,
    required this.country,
    required this.isVerified,
    required this.schema,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    // final List<dynamic> categoryJsonList = json['category'] as List<dynamic>;
    // final List<CategoryModel> categoryList = categoryJsonList.map((categoryJson) => CategoryModel.fromJson(categoryJson)).toList();

    final List<dynamic> imagesJsonList = json['images'] as List<dynamic>;
    final List<ImageModel> imagesList = imagesJsonList
        .map((imageJson) => ImageModel.fromJson(imageJson))
        .toList();

    final schemaJson = json['schema'] as Map<String, dynamic>;
    final schema = SchemaModel.fromJson(schemaJson);

    return MyModel(
      id: json['_id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      category: (json['category'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList(),
      heading: json['heading'] as String,
      subHeading: json['sub_heading'] as String,
      full_detail: json['full_detail'] as String,
      summary: json['summary'] as String,
      images: imagesList,
      country: json['country'] as String,
      isVerified: json['is_verified'] as bool,
      schema: schema,
    );
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> categoryJsonList =
        category.map((category) => category.toJson()).toList();
    final List<Map<String, dynamic>> imagesJsonList =
        images.map((image) => image.toJson()).toList();
    final schemaJson = schema.toJson();

    return {
      '_id': id,
      'user': user.toJson(),
      'createdAt': createdAt,
      'category': categoryJsonList,
      'heading': heading,
      'sub_heading': subHeading,
      'full_detail': full_detail,
      'summary': summary,
      'images': imagesJsonList,
      'country': country,
      'is_verified': isVerified,
      'schema': schemaJson,
    };
  }
}

class UserModel {
  final int id;
  final bool isAdmin;
  final String username;
  final String email;
  final String name;

  UserModel({
    required this.id,
    required this.isAdmin,
    required this.username,
    required this.email,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as int,
      isAdmin: json['is_admin'] as bool,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'is_admin': isAdmin,
      'username': username,
      'email': email,
      'name': name,
    };
  }
}

// class CategoryModel {
//   final List<dynamic> keyword;
//
//   CategoryModel({required this.keyword});
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(keyword: json['keyword'] as List<dynamic>);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'keyword': keyword};
//   }
// }
class Category {
  List<String> keyword;

  Category({
    required this.keyword,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      keyword: (json['keyword'] as String)
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(','),
    );
  }
  Map<String, dynamic> toJson() {
    return {'keyword': keyword};
  }
}

class ImageModel {
  final String image;
  final String thumbnailImage;
  final bool isThumbnail;

  ImageModel(
      {required this.image,
      required this.thumbnailImage,
      required this.isThumbnail});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      image: json['image'] as String,
      thumbnailImage: json['thumbnail_image'] as String,
      isThumbnail: json['thumbnail'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'thumbnail_image': thumbnailImage,
      'thumbnail': isThumbnail
    };
  }
}

class SchemaModel {
  final String id;
  final String schemaName;
  final SchemaDataModel schemaData;

  SchemaModel(
      {required this.id, required this.schemaName, required this.schemaData});

  factory SchemaModel.fromJson(Map<String, dynamic> json) {
    final schemaDataJson = json['schema'] as Map<String, dynamic>;
    final schemaData = SchemaDataModel.fromJson(schemaDataJson);

    return SchemaModel(
      id: json['_id'] as String,
      schemaName: json['schema_name'] as String,
      schemaData: schemaData,
    );
  }

  Map<String, dynamic> toJson() {
    final schemaDataJson = schemaData.toJson();

    return {
      '_id': id,
      'schema_name': schemaName,
      'schema': schemaDataJson,
    };
  }
}

class SchemaDataModel {
  final String id;
  final int monthCount;
  final String monthlyStipend;

  SchemaDataModel(
      {required this.id,
      required this.monthCount,
      required this.monthlyStipend});

  factory SchemaDataModel.fromJson(Map<String, dynamic> json) {
    return SchemaDataModel(
      id: json['_id'] as String,
      monthCount: json['month_cnt'] as int,
      monthlyStipend: json['monthly_stipend'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'month_cnt': monthCount,
      'monthly_stipend': monthlyStipend
    };
  }
}
// class MyModel {
//   String id;
//   //UserModel user;
//   DateTime createdAt;
//   List<CategoryModel> category;
//   String heading;
//   String subHeading;
//   String full_detail;
//   String summary;
//   List<String> images;
//   String country;
//   bool isVerified;
//   SchemaModel schema;
//
//   MyModel({
//     required this.id,
//     //required this.user,
//     required this.createdAt,
//     required this.category,
//     required this.heading,
//     required this.subHeading,
//     required this.full_detail,
//     required this.summary,
//     required this.images,
//     required this.country,
//     required this.isVerified,
//     required this.schema,
//   });
//
//   factory MyModel.fromJson(Map<String, dynamic> json) {
//     return MyModel(
//       id: json['_id'],
//       //user: UserModel.fromJson(json['user']),
//       createdAt: DateTime.parse(json['createdAt']),
//       category: List<CategoryModel>.from(json['category'].map((x) => CategoryModel.fromJson(x))),
//       heading: json['heading'],
//       subHeading: json['sub_heading'],
//       full_detail: json['full_detail'],
//       summary: json['summary'],
//       images: List<String>.from(json['images']),
//       country: json['country'],
//       isVerified: json['is_verified'],
//       schema: SchemaModel.fromJson(json['schema']),
//     );
//   }
// }
//
// // class UserModel {
// //   int id;
// //   bool isAdmin;
// //   String username;
// //   String email;
// //   String name;
// //
// //   UserModel({
// //     required this.id,
// //     required this.isAdmin,
// //     required this.username,
// //     required this.email,
// //     required this.name,
// //   });
// //
// //   factory UserModel.fromJson(Map<String, dynamic> json) {
// //     return UserModel(
// //       id: json['_id'],
// //       isAdmin: json['is_admin'],
// //       username: json['username'],
// //       email: json['email'],
// //       name: json['name'],
// //     );
// //   }
// // }
//
// class CategoryModel {
//   String keyword;
//
//   CategoryModel({required this.keyword});
//
//   factory CategoryModel.fromJson(Map<String, dynamic> json) {
//     return CategoryModel(keyword: json['keyword']);
//   }
// }
//
// class SchemaModel {
//   String id;
//   String schemaName;
//   SchemaDetailsModel schemaDetails;
//
//   SchemaModel({required this.id, required this.schemaName, required this.schemaDetails});
//
//   factory SchemaModel.fromJson(Map<String, dynamic> json) {
//     return SchemaModel(
//       id: json['_id'],
//       schemaName: json['schema_name'],
//       schemaDetails: SchemaDetailsModel.fromJson(json['schema']),
//     );
//   }
// }
//
// class SchemaDetailsModel {
//   String id;
//   int monthCount;
//   String monthlyStipend;
//
//   SchemaDetailsModel({required this.id, required this.monthCount, required this.monthlyStipend});
//
//   factory SchemaDetailsModel.fromJson(Map<String, dynamic> json) {
//     return SchemaDetailsModel(
//       id: json['_id'],
//       monthCount: json['month_cnt'],
//       monthlyStipend: json['monthly_stipend'],
//     );
//   }
// }