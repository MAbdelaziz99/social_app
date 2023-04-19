import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultShimmerItem extends StatelessWidget {

  final Widget childWidget;
  const DefaultShimmerItem({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.grey,
      highlightColor: Colors.grey[100] ?? Colors.grey,
      child: childWidget,
    );
  }
}
