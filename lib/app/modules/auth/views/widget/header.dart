import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:stock_ease/app/theme/color.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'Stock Ease',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: Text(
              textAlign: TextAlign.center,
              'Mobile-Web Application Stock\nManagement',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 60.0,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12.0,
                  color: Colors.black,
                ),
                Expanded(
                  child: DottedLine(
                    dashLength: 2,
                    dashGapLength: 3,
                    lineThickness: 2,
                    dashRadius: 16,
                    dashColor: Colors.black,
                  ),
                ),
                Icon(
                  Icons.circle,
                  size: 12.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
