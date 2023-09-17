import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/AdHelper.dart';

class AdBanner extends StatefulWidget {
  AdBanner({Key? key}) : super(key: key);

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _initGoogleMobileAds();
    _loadBannerAd();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }
  //fullBanner

  void _loadBannerAd() {
    BannerAd banner = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    );

    banner.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null) print("if(_bannerAd == null)");
    return Container(
      height: 60,
      color: Colors.white,
      child: _bannerAd == null
          ? SizedBox.shrink()
          : AdWidget(ad: _bannerAd!), // 使用 AdWidget 顯示廣告
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }
}
