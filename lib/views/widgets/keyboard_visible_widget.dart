import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class KeyboardVisibleWidget extends StatefulWidget {
  const KeyboardVisibleWidget({
    Key key,
    @required this.child,
    @required this.focusNode,
    @required this.scrollController,
    this.curve: Curves.ease,
    this.duration: const Duration(milliseconds: 100),
  }) : super(key: key);

  /// The node we will monitor to determine if the child is focused
  final FocusNode focusNode;

  /// The child widget that we are wrapping
  final Widget child;

  final ScrollController scrollController;
  /// The curve we will use to scroll ourselves into view.
  ///
  /// Defaults to Curves.ease.
  final Curve curve;

  /// The duration we will use to scroll ourselves into view
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  KeyboardVisibleWidgetState createState() => new KeyboardVisibleWidgetState();
}

class KeyboardVisibleWidgetState extends State<KeyboardVisibleWidget> {


  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_ensureVisible);

  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(_ensureVisible);
  }

  Future<Null> _ensureVisible() async {

    // Wait for the keyboard to come into view
    // TODO: position doesn't seem to notify listeners when metrics change,
    // perhaps a NotificationListener around the scrollable could avoid
    // the need insert a delay here.
    await new Future.delayed(const Duration(milliseconds: 300));

    if (!widget.focusNode.hasFocus)
      return;

    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
    assert(viewport != null);
  
    ScrollPosition position = widget.scrollController.position;
    double alignment;

    if (position.pixels > viewport.getOffsetToReveal(object, 0.0)) {
      // Move down to the top of the viewport
      alignment = 0.0;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0)) {
      // Move up to the bottom of the viewport
      alignment = 1.0;
    } else {
      // No scrolling is necessary to reveal the child
      alignment = 0.5;
    }
    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  Widget build(BuildContext context) => widget.child;
}
