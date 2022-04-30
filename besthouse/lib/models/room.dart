class Room {
  String type;
  int amount;
  List<String> pictures;

  Room({
    required this.type,
    required this.amount,
    required this.pictures,
  });

  set setType(String value) => type = value;
  set setAmount(int value) => amount = value;
  set setPictures(List<String> value) => pictures = value;

  Map<String, dynamic> toJson() => {
        "type": type,
        "amount": amount,
        "pictures": pictures,
      };
}
