import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeIcons {
  static String assetName(icon) {
    return 'assets/icons/$icon.svg';
  } 
  static get inactiveGrey {
    return Color.fromARGB(255, 111, 111, 111);
  }
  static get homeBlack {
    return SvgPicture.asset(
      GeIcons.assetName("home_black"),
      height: 24,
      width: 24,
    );
  }
  static get homeGrey {
    return SvgPicture.asset(
      GeIcons.assetName("home_black"),
      height: 24,
      width: 24,
      color: GeIcons.inactiveGrey,
    );
  }
  static get personBlack {
    return SvgPicture.asset(
      GeIcons.assetName("person_grey"),
      height: 24,
      width: 24,
      color: Colors.black,
    );
  }
  static get personGrey {
    return SvgPicture.asset(
      GeIcons.assetName("person_grey"),
      height: 24,
      width: 24,
      color: GeIcons.inactiveGrey,
      
    );
  }
  static get cartBlack {
    return SvgPicture.asset(
      GeIcons.assetName("cart_black"),
      height: 24,
      width: 24,
      
    );
  }
  static get cartGrey {
    return SvgPicture.asset(
      GeIcons.assetName("cart_black"),
      height: 24,
      width: 24,
      color: GeIcons.inactiveGrey,
    );
  }
  static get commandsBlack {
    return SvgPicture.asset(
      GeIcons.assetName("commands"),
      height: 24,
      width: 24,
      color: Colors.black
      
    );
  }
  static get commandsGrey{
    return SvgPicture.asset(
      GeIcons.assetName("commands"),
      height: 24,
      width: 24,
      color: GeIcons.inactiveGrey,
      
    );
  }



  static get back {
    return SvgPicture.asset(
      GeIcons.assetName("back")
    );
  }
  
  static get cash {
    return SvgPicture.asset(
      GeIcons.assetName("cash")
    );
  }
  static get eye {
    return SvgPicture.asset(
      GeIcons.assetName("eye")
    );
  }
  static get registerAcceptance {
    return SvgPicture.asset(
      GeIcons.assetName("register_acceptance")
    );
  }
  
  static get phone {
    return SvgPicture.asset(
      GeIcons.assetName("phone")
    );
  }
  static get locationArrow {
    return SvgPicture.asset(
      GeIcons.assetName("location_arrow")
    );
  }
  static get LocationMarkerBlack {
    return SvgPicture.asset(
      GeIcons.assetName("location_marker_black")
    );
  }
  static get loadingOk {
    return SvgPicture.asset(
      GeIcons.assetName("loading_ok"),
      height: 24,
      width: 24
    );
  }
  static get loadingOkSmall {
    return SvgPicture.asset(
      GeIcons.assetName("loading_ok")
    );
  }
  static get search {
    return SvgPicture.asset(
      GeIcons.assetName("search")
    );
  }
  static get cross {
    return SvgPicture.asset(
      GeIcons.assetName("search")
    );
  }

}