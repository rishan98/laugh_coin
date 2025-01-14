import 'package:laugh_coin/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrl {
  ShowToast toast = ShowToast();
  Future<void> openURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      toast.showToastError('Could not launch $url');
    }
  }
}
