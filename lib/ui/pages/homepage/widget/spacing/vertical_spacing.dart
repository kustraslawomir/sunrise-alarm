import 'package:flutter/cupertino.dart';

import '../../../../theme/dimensions.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: Dimensions.verticalWidgetSpacing);
  }
}
