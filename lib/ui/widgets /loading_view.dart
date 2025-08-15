import 'package:flutter/material.dart';
import 'package:news/ui/utils%20/extensions/build_context_extensions.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.secondaryColor),
    );
  }
}
