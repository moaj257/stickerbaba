import 'package:stickerbaba/models/Sticker.dart';

class StickerPack {
  final String identifier;
  final String name;
  final String publisher;
  final String trayImageFile;
  final String publisherEmail;
  final String publisherWebsite;
  final String privacyPolicyWebsite;
  final String licenseAgreementWebsite;
  final List<dynamic> stickers;

  StickerPack._(
      {required this.identifier,
      required this.name,
      required this.publisher,
      required this.trayImageFile,
      required this.publisherEmail,
      required this.publisherWebsite,
      required this.privacyPolicyWebsite,
      required this.licenseAgreementWebsite,
      required this.stickers});

  factory StickerPack.fromJson(Map<String, dynamic> json) {
    List<dynamic> stickr = <Sticker>[];
    stickr = json['stickers'].map((data) => Sticker.fromJson(data)).toList();
    return StickerPack._(
        identifier: json['identifier'],
        name: json['name'],
        publisher: json['publisher'],
        trayImageFile: json['tray_image_file'],
        publisherEmail: json['publisher_email'],
        publisherWebsite: json['publisher_website'],
        privacyPolicyWebsite: json['privacy_policy_website'],
        licenseAgreementWebsite: json['license_agreement_website'],
        stickers: stickr);
  }
}
