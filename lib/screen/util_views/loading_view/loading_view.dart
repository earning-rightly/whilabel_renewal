import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/login/login_view_model.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_model.dart';

class LoadingView extends ConsumerWidget {
  final Widget child;

  const LoadingView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loadingViewModelProvider);
    return Stack(
      children: [
        child,
        if (state.isLoading == true)
          const Center(child: CircularProgressIndicator())
        else
          const SizedBox(),
      ],
    );
  }
}