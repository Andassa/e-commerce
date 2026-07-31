import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'circle_icon_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleIconButton(
      icon: Icons.arrow_back,
      onTap: () => context.pop(),
    );
  }
}
