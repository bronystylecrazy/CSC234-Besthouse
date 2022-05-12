class UserProfile {
  final String firstname;
  final String lastname;
  final String? lineId;
  final String? facebook;
  final String id;
  final String? pictureUrl;

  const UserProfile(
      {required this.id,
      required this.firstname,
      required this.lastname,
      this.lineId = "",
      this.facebook = "",
      this.pictureUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        id: json['user_id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        pictureUrl: json['picture_url']);
  }
}

class UserProfileCard {
  final String label;
  final String value;
  final bool isEditable;

  const UserProfileCard(this.label, this.value, this.isEditable);
}
