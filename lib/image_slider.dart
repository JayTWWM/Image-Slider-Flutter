import 'dart:async';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<Widget> children;
  bool autoSlide;
  bool allowManualSlide;
  Curve curve;
  Duration duration;
  final double width;
  final double height;
  bool showTabIndicator;
  Color tabIndicatorColor;
  Color tabIndicatorSelectedColor;
  double tabIndicatorSize;
  double tabIndicatorHeight;
  TabController tabController;

  ImageSlider(
      {@required this.children,
      @required this.width,
      @required this.height,
      this.curve,
      this.tabIndicatorColor = Colors.white,
      this.tabIndicatorSelectedColor = Colors.black,
      this.tabIndicatorSize = 12,
      this.tabIndicatorHeight = 10,
      this.allowManualSlide = true,
      this.autoSlide = false,
      this.showTabIndicator = false,
      this.tabController,
      this.duration = const Duration(seconds: 3)});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    myTabController =
        TabController(length: widget.children.length, vsync: this);
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

  Timer timer;
  ScrollPhysics scrollPhysics;
  TabController myTabController;

  @override
  Widget build(BuildContext context) {
    if (widget.tabController == null) {
      widget.tabController = myTabController;
    }
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
