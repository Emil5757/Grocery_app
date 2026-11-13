import 'package:flutter/material.dart';

/// The only place that touches `Navigator`. Pages call `Go.to(context, Pager.x)`.
abstract final class Go {
  static Future<T?> to<T>(BuildContext context, Widget page) =>
      Navigator.of(context).push<T>(_route(page));

  static Future<T?> replace<T>(BuildContext context, Widget page) =>
      Navigator.of(context).pushReplacement<T, void>(_route(page));

  static Future<T?> removeAll<T>(BuildContext context, Widget page) =>
      Navigator.of(context).pushAndRemoveUntil<T>(_route(page), (_) => false);

  static void back<T>(BuildContext context, [T? result]) =>
      Navigator.of(context).pop<T>(result);

  static Future<T?> sheet<T>(BuildContext context, Widget child) => showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        builder: (_) => child,
      );

  static Future<T?> dialog<T>(BuildContext context, Widget child) =>
      showDialog<T>(context: context, builder: (_) => child);

  static MaterialPageRoute<T> _route<T>(Widget page) =>
      MaterialPageRoute<T>(builder: (_) => page);
}
