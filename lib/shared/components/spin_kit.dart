import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_app/shared/style/colors.dart';

class DefaultSpinKit extends StatelessWidget {
  final double size;

  const DefaultSpinKit({Key? key, this.size = 30.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: blueColor,
      size: size,
    );
  }
}
