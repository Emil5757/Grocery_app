/// OpenStreetMap settings for `flutter_map`.
///
/// The public OSM tile server asks every app to identify itself
/// (https://operations.osmfoundation.org/policies/tiles/) and to show the
/// "© OpenStreetMap contributors" attribution, which the tracking page does.
/// For heavy production traffic switch [tileUrl] to a paid/self-hosted
/// provider.
abstract final class AppMap {
  static const String tileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String userAgentPackageName = 'com.example.grocery_app';
  static const String copyrightUrl = 'https://www.openstreetmap.org/copyright';
  static const double trackingZoom = 15.5;
  static const double maxZoom = 19;
}
