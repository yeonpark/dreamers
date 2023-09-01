class Story {
  String id;
  UserModel user;
  DateTime createdAt;
  List<CategoryModel> category;
  String heading;
  String subHeading;
  String fullDetail;
  String summary;
  List<ImageModel> images;
  String country;
  bool isVerified;
  List<Like> likes;

  Story({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.category,
    required this.heading,
    required this.subHeading,
    required this.fullDetail,
    required this.summary,
    required this.images,
    required this.country,
    required this.isVerified,
    required this.likes,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      createdAt: DateTime.parse(json['created_at']),
      category: (json['category'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      heading: json['heading'],
      subHeading: json['sub_heading'],
      fullDetail: json['full_detail'],
      summary: json['summary'],
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e))
          .toList(),
      country: json['country'],
      isVerified: json['is_verified'],
      likes: List<Like>.from(json['likes'].map((like) => Like.fromJson(like))),
    );
  }
}

class UserModel {
  int user;
  String profileImage;
  int donationsMade;
  int storyMade;
  int totalDonationSize;
  DateTime createdAt;
  String introduction;

  UserModel({
    required this.user,
    required this.profileImage,
    required this.donationsMade,
    required this.storyMade,
    required this.totalDonationSize,
    required this.createdAt,
    required this.introduction,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json['user'],
      profileImage: json['profile_image'],
      donationsMade: json['donations_made'],
      storyMade: json['story_made'],
      totalDonationSize: json['total_donation_size'],
      createdAt: DateTime.parse(json['createdAt']),
      introduction: json['introduction'],
    );
  }
}

class CategoryModel {
  String keyword;

  CategoryModel({required this.keyword});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(keyword: json['keyword']);
  }
}

class ImageModel {
  String image;
  bool thumbnail;

  ImageModel({required this.image, required this.thumbnail});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(image: json['image'], thumbnail: json['thumbnail']);
  }
}

class Like {
  int user;

  Like({required this.user});

  factory Like.fromJson(Map<String, dynamic> json) => Like(user: json['user']);
}
