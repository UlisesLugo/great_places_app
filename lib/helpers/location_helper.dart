import 'package:flutter_dotenv/flutter_dotenv.dart';

final key = dotenv.get('GOOGLE_API_KEY', fallback: 'Test');

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude = 0, double longitude = 0}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude' +
        '&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$key';
  }
}
