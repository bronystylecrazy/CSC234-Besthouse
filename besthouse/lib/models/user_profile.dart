class UserProfile {
  final String firstname;
  final String lastname;
  final String lineId;
  final String facebook;

  UserProfile({
    required this.firstname,
    required this.lastname,
    this.lineId = "",
    this.facebook = "",
  });
}

class UserProfileCard {
  final String label;
  final String value;
  final bool isEditable;

  const UserProfileCard(this.label, this.value, this.isEditable);
}
