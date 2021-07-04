import 'package:flutter/material.dart';
import '../constants.dart';

class NoDataIndicator extends StatelessWidget {
  NoDataIndicator({this.caption});
  final String caption;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list,
            size: 70.0,
            color: Colors.grey,
          ),
          Text(
            caption,
            style: kEmptyPageTextStyle,
          ),
        ],
      ),
    );
  }
}
