import 'package:flutter/material.dart';
import 'package:stock_ease/app/modules/auth/views/widget/curve_clipper.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: Colors.white,
                    height: 140.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Copyright \u00a9 Stock Ease',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
