import 'package:confwebsite2021/utils/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkModel {
  _LinkModel({
    required this.name,
    required this.url,
    this.icon,
    this.tooltip,
  });

  final String name;
  final String url;
  final String? tooltip;
  final Widget? icon;
}

class NavBar extends StatelessWidget {
  final navLinks = [
    _LinkModel(name: 'Home', url: '/'),
    _LinkModel(name: 'Event', url: 'https://flutter-jp.connpass.com/'),
    _LinkModel(
      name: 'ツイート',
      tooltip: '#FlutterKaigi でツイートしよう！',
      url: 'https://twitter.com/intent/tweet?hashtags=FlutterKaigi',
      icon: SvgPicture.asset(
        '/twitter_white.svg',
        width: 20,
      ),
    ),
  ];

  List<Widget> navItem() {
    return [
      for (final link in navLinks) ...[
        const SizedBox(width: 18),
        if (link.icon == null)
          ElevatedButton(
            onPressed: () async {
              await launch(link.url);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
            ),
            child: Text(
              link.name,
              style: const TextStyle(fontFamily: 'Montserrat-Bold'),
            ),
          )
        else
          FloatingActionButton.extended(
            tooltip: link.tooltip,
            icon: link.icon,
            label: Text(link.name),
            onPressed: () async {
              await launch(link.url);
            },
          ),
      ]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  '/flutterkaigi-navbar_logo.svg',
                  width: 240,
                ),
              ],
            ),
            if (!ResponsiveLayout.isSmallScreen(context))
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[...navItem()])
          ],
        ),
      ),
    );
  }
}
