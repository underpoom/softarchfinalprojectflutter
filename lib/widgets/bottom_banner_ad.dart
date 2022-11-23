import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {
  // Banner ads automatically show new ads after a certain period of time.
  // You do not need to do anything fancy with timers or resetting this variable.
  //final banner = GetIt.instance.get<AdService>().getBannerAd();

  @override
  void dispose() {
    super.dispose();
  }

  String ads =
      "https://lh3.googleusercontent.com/p/AF1QipNgFsi8U7oENhNoGeiHI69A0micRa1JChpDFE7J=s680-w680-h510";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(ads), fit: BoxFit.cover)),
      child: ListTile(
        onTap: _launchURL,
      ),
      //color: Colors.transparent,
      width: double.infinity,
      height: 50,
    );
  }

  _launchURL() async {
    const url = 'https://liff.line.me/1645278921-kWRPP32q/?accountId=274blseg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
