import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  static callService() async {
    Uri uri = Uri(scheme: 'tel', path: '+917838563831');
    await launchUrl(uri);
  }
}
