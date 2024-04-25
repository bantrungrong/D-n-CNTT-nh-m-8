import 'package:flutter/cupertino.dart';

class MyIcon {
  static const String imagePath = 'assets/icon/';
  static const String detail = imagePath + 'detail.png';
  static const String factory = imagePath + 'factory.png';
  static const String drink = imagePath + 'drink.png';
  static const String product = imagePath + 'product.png';
  static const String shop = imagePath + 'shop.jpeg';
  static const String take = imagePath + 'take.png';
  static const String travel = imagePath + 'travel.png';
}
class MyImage {
  static const String imagePath = 'assets/images/';
  static const String back_ground_image = imagePath + 'trongdong.png';
  static const String back_ground = imagePath + 'trong_dong.png';
}

class AppIconData extends StatelessWidget {
  final double height;
  final double width;
  final String iconData;
  const AppIconData({super.key,required this.iconData,required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(iconData)
        )
      ),
    );
  }
}
