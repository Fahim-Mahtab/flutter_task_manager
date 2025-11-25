import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            AssetPaths.backgroundImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          child,
        ],
      ),
    );
  }
}
