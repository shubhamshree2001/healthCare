import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';

class ImageCircularView extends GetWidget
{
  final double size;
  const ImageCircularView({
    Key? key,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Container(
              color: AppColors.colorWhite,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size/2,
                color: AppColors.colorHawkesBlue,
              ),
            ),
            Image.network("https://image.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1768126784.jpg")
          //  SvgPicture.network("https://image.shutterstock.com/image-photo/young-handsome-man-beard-wearing-260nw-1768126784.jpg")
          ],
        ),
      ),
    );
  }

}