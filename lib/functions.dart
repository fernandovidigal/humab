import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:humab/constants.dart';
import 'package:humab/helpers/screen_helper.dart';

String formatData(DateTime data) {
  return "${data.day} de ${meses[data.month - 1]['mes']}";
}

Widget showLoading() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
    ),
  );
}

Widget showError() {
  return Center(
    child: Text(
      "Não foi possível carregar os dados",
      style: TextStyle(color: Colors.red, fontSize: 16.sp),
    ),
  );
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

Widget showAdBanner({required BannerAd banner}) {
  return Container(
    child: AdWidget(ad: banner),
    width: banner.size.width.toDouble(),
    height: banner.size.height.toDouble(),
    alignment: Alignment.center,
  );
}
