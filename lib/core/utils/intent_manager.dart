import 'package:url_launcher/url_launcher.dart' as url_launcher;

class IntentManager {
  /// Launch the given [url] and delegate its handling to the platform.
  static Future<void> launchUrl(String url) async {
    try {
      if (url != null && url.isNotEmpty) {
        if (await url_launcher.canLaunch(url)) {
          await url_launcher.launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
      return;
    } catch (e) {
      return;
    }
  }
}
