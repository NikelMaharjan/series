import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {


  final double? size;
  const LoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitFadingCube(
    color: Colors.red,
    size: size ?? 40,
    ) );

  }
}
