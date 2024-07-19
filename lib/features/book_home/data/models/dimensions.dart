
class Dimensions {
  String? height;
  String? width;
  String? thickness;

  Dimensions({this.height, this.width, this.thickness});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    height: json['height'] as String?,
    width: json['width'] as String?,
    thickness: json['thickness'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'height': height,
    'width': width,
    'thickness': thickness,
  };
}
