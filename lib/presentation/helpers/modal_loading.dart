import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

void modalLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black54,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: const [
                TextCustom(
                    text: 'Helpin',
                    color: ColorsFrave.primaryColor,
                    fontWeight: FontWeight.w500)
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Row(
              children: const [
                CircularProgressIndicator(color: ColorsFrave.primaryColor),
                SizedBox(width: 15.0),
                TextCustom(text: 'Loading...')
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
