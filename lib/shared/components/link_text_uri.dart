import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../style/colors.dart';

Future<void> openUrl(String url, context) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    defaultErrorSnackBar(message: 'Failed to open site',  title: 'Open a site');
  }
}

List<TextSpan> extractText(String rawString, context) {
  List<TextSpan> textSpan = [];

  final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  getLink(String linkString, context) {
    textSpan.add(
      TextSpan(
        text: linkString,
        style: const TextStyle(color: orangeColor),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            openUrl(linkString, context);
          },
      ),
    );
    return linkString;
  }

  getNormalText(String normalText, context) {
    textSpan.add(
      TextSpan(
        text: normalText,
        style: const TextStyle(color: Colors.black),
      ),
    );
    return normalText;
  }

  rawString.splitMapJoin(
    urlRegExp,
    onMatch: (m) => getLink("${m.group(0)}", context),
    onNonMatch: (n) => getNormalText(n.substring(0), context),
  );

  return textSpan;
}
