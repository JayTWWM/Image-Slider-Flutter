import 'dart:async';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  /// Children in slideView to slide
  final List<Widget> children;

  /// If automatic sliding is required
  final bool autoSlide;

  /// If manual sliding is required
  final bool allowManualSlide;

  /// Animation curves of sliding
  final Curve curve;

  /// Time for automatic sliding
  final Duration duration;

  /// Width of the slider
  final double width;

  /// Height of the slider
  final double height;

  /// Shows the tab indicating circles at the bottom
  final bool showTabIndicator;

  /// Cutomize tab's colors
  final Color tabIndicatorColor;

  /// Customize selected tab's colors
  final Color tabIndicatorSelectedColor;

  /// Size of the tab indicator circles
  final double tabIndicatorSize;

  /// Height of the indicators from the bottom
  final double tabIndicatorHeight;

  /// tabController for walkthrough or other implementations
  final TabController tabController;

  ImageSlider(
      {required this.children,
      required this.width,
      required this.height,
      required this.curve,
      this.tabIndicatorColor = Colors.white,
      this.tabIndicatorSelectedColor = Colors.black,
      this.tabIndicatorSize = 12,
      this.tabIndicatorHeight = 10,
      this.allowManualSlide = true,
      this.autoSlide = false,
      this.showTabIndicator = false,
      required this.tabController,
      this.duration = const Duration(seconds: 3)});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with SingleTickerProviderStateMixin {
  /// Setting timer and physics on init!
  @override
  void initState() {
    if (widget.autoSlide) {
      timer = Timer.periodic(widget.duration, (Timer t) {
        widget.tabController.animateTo(
            (widget.tabController.index + 1) % widget.tabController.length,
            curve: widget.curve);
      });
    }
    if (widget.allowManualSlide) {
      scrollPhysics = ScrollPhysics();
    } else {
      scrollPhysics = NeverScrollableScrollPhysics();
    }
    super.initState();
  }

//Declared Timer and physics.
  late Timer timer;
  late ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    // Container has a stack with the tab indicators and the tab bar view!
    return Container(
        width: widget.width,
        height: widget.height,
        child: Stack(children: [
          TabBarView(
            controller: widget.tabController,
            children: widget.children,
            physics: scrollPhysics,
          ),
          widget.showTabIndicator
              ? Positioned(
                  bottom: widget.tabIndicatorHeight,
                  child: Container(
                      width: widget.width,
                      child: Center(
                          child: TabPageSelector(
                        controller: widget.tabController,
                        color: widget.tabIndicatorColor,
                        selectedColor: widget.tabIndicatorSelectedColor,
                        indicatorSize: widget.tabIndicatorSize,
                      ))))
              : Container(
                  width: 0,
                  height: 0,
                ),
        ]));
  }
}
