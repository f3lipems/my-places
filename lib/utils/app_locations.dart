const googleApiKey = 'AIzaSyB71f279UlZoAku3bIcvSyKSyaH7sUAnoo';

class AppLocations {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }
}
