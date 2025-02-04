import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermWidget extends StatelessWidget {
  const TermWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(
            'https://sites.google.com/view/mata-ar-privacy-policy?usp=sharing');
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
        child:const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: const Text(
                textAlign: TextAlign.center,
                ' Syarat dan Ketentuan serta Kebijakan Privasi kami',
                maxLines:2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
    );
  }
}
