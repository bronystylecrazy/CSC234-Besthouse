class GuideModel {
  final String name;
  final String description;
  bool isExpanded = false;

  GuideModel(this.name, this.description);

  GuideModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"];
}
