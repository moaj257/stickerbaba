class Sticker {
  final String imageFile;
  final List emojis;

  Sticker._({required this.imageFile, required this.emojis});

  factory Sticker.fromJson(Map<String, dynamic> json) {
    return Sticker._(
        imageFile: json['image_file'], emojis: json['emojis'] as List);
  }
}
