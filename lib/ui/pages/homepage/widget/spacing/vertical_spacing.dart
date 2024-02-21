import 'package:flutter/cupertino.dart';

import '../../../../theme/dimensions.dart';

enum VerticalSpacingSize { small, regular, large }

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({super.key, this.size = VerticalSpacingSize.regular});

  final VerticalSpacingSize size;

  @override
  Widget build(BuildContext context) {
    var height = Dimensions.verticalWidgetSpacingRegular;
    switch (size) {
      case VerticalSpacingSize.small:
        height = Dimensions.verticalWidgetSpacingSmall;
        break;
      case VerticalSpacingSize.regular:
        height = Dimensions.verticalWidgetSpacingRegular;
        break;
      case VerticalSpacingSize.large:
        height = Dimensions.verticalWidgetSpacingLarge;
        break;
    }
    return SizedBox(height: height);
  }
}
