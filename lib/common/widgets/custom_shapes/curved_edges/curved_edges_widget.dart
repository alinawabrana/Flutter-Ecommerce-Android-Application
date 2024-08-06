import 'package:flutter/material.dart';

import 'curved_edges.dart';

class TCurveEdgesWidget extends StatelessWidget {
  const TCurveEdgesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: TCustomCurvedEdges(), child: child);
  }
}
