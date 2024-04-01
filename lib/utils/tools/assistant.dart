import 'package:url_launcher/url_launcher.dart';

import 'file_importer.dart';

double height(context) => MediaQuery.of(context).size.height;
double width(context) => MediaQuery.of(context).size.width;

Future<void> launchMyUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}