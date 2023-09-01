class Notification {
  final int id;
  final String title;
  final String description;
  bool read;
  final int user;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.read,
    required this.user,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      read: json['read'],
      user: json['user'],
    );
  }
}