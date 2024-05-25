

import 'package:flutter/cupertino.dart';
import 'package:hightech_pharmacy/core/Class/status_request.dart';
import 'package:lottie/lottie.dart';

import '../constant/image_asset.dart';




class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest ;
  final Widget widget ;
  const HandlingDataView({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return
      statusRequest == StatusRequest.loading ?
      Center(child: Lottie.asset(ImageAssets.loading,height: 350)) :
      statusRequest == StatusRequest.offlinefailure ?
      Center(child: Lottie.asset(ImageAssets.offline,height: 350)) :
      statusRequest == StatusRequest.serverFailure ?
      Center(child: Lottie.asset(ImageAssets.server)) :
      statusRequest == StatusRequest.serverException ?
      Center(child: Lottie.asset(ImageAssets.server)) :
      statusRequest == StatusRequest.failure ?
      Center(child: Lottie.asset(ImageAssets.noData)) :
      widget;

  }
}


class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest ;
  final Widget widget ;
  const HandlingDataRequest({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return
      statusRequest == StatusRequest.loading ?
      Center(child: Lottie.asset(ImageAssets.loading)) :
      statusRequest == StatusRequest.offlinefailure ?
      Center(child: Lottie.asset(ImageAssets.offline)) :
      statusRequest == StatusRequest.serverFailure ?
      Center(child: Lottie.asset(ImageAssets.server)) :
      widget;

  }
}