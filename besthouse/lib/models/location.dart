class Location {
  List<double> coordinates;
  final String type = 'Point';

  Location({
    required this.coordinates,
  });

  set setLocation(List<double> value) => coordinates = value;

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
      };
}
