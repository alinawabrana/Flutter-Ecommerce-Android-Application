import 'package:flutter/material.dart';

/// STEPS TO CREATE A CLIPPED PATH:

// We are going to divide this shape into 3 parts: a curve, a straight line & a curve
// For that we need a quadratic desired effect

// First we need to define the start point using path.lineTo()

// Now to start creating design or custom shape lets create a variable and assign Offset to it
// We use Offset to define the points of x and y axis

// 0 means left side and height - 20 means to create curve from 0 to height - 20
// 30 and height - 20 will create a curve as well starting from x = 30 and clip it as height - 20

// Now to add this inside the path we will use quadraticBezierTo and provide the first and last curves. This will create the first curve

// Now for the second curve (straight line), we use 0 for x axis means th start point of where we ended the path previously and height - 20 for pushing it upward to tell the start point of curve
// Then we use width - 30 for x to specify to what extents the straight line should exist and height - 20 for y

// Finally the third curve (end curve), we use size.width for create curve back to the full x axis width and size.height - 20 for the start of the curve at the same height as straight line
// Then we use the same size.width for x and size.height for y axis to tell where the curve should end.

// NOTE: as we want to bring our curve back to its original position therefore as we use 0 as x-axis in start that's why we use size.width in the last curve.

// MANDATORY: After defining all the path curves, we will define the end points using path.lineTo. As previously we use 0 as starting pints therefore we use size.width as end point to consider full width, similarly we use 0 for height as we use height - 20 before.
// After defining end points we can clos the path using path.close and return the path.

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path(); // Path is going to define a shape

    path.lineTo(0, size.height); // This is left bottom x = 0, y = height

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLastCurve = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  // As right now we don't need the shouldReclip, therefore we will return true
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
