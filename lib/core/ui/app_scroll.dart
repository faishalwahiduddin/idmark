import 'package:flutter/material.dart';

/// Shared scroll feel + shell inset for [NavigationShell] with `extendBody`.
abstract final class AppScroll {
  static const ScrollPhysics physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  static EdgeInsets pagePadding(
    BuildContext context, {
    double horizontal = 16,
    double top = 16,
    double extraBottom = 24,
  }) {
    final safe = MediaQuery.paddingOf(context).bottom;
    const navBarHeight = 80.0;
    return EdgeInsets.fromLTRB(
      horizontal,
      top,
      horizontal,
      navBarHeight + safe + extraBottom,
    );
  }
}
