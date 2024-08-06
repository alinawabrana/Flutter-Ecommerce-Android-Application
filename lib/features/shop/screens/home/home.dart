import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

/// TCircularContainer is a separate class that we created to create a container having two half circles stacked at the right side of the screen.
/// After that we wrap the Container with the ClipPath widgets to create three clip Paths: (1) the clip at left bottom (2) A straight line after that (3) the clip at right bottom
/// Also, We didn't use the border radius because the borders are created towards inner direction but we want the clipped in the opposite direction.
///This ClipPath widget is used inside the TCurvedEdgesWidget class.

/// To use the ClipPath widget and to apply clipping, we use clipper property which takes CustomClipper<Path? as an input.
/// For that we will create a separate class, because CustomClipper<Path> carries two functions within it

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Container(
                constraints: const BoxConstraints.expand(height: 400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
