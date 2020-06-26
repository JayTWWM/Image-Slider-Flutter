import 'dart:async';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  List<Widget> children;
  bool autoSlide;
  bool allowManualSlide;
  Curve curve;
  Duration duration;
  double width;
  double height;

  ImageSlider(
      {@required this.children,
      @required this.width,
      @required this.height,
      this.curve,
      this.allowManualSlide = true,
      this.autoSlide = false,
      this.duration = const Duration(seconds: 3)});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.children.length, vsync: this);
    if (widget.autoSlide) {
      timer = Timer.periodic(widget.duration, (Timer t) {
        _tabController.animateTo(
            (_tabController.index + 1) % _tabController.length,
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

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        child: TabBarView(
          controller: _tabController,
          children: widget.children,
          physics: scrollPhysics,
        ));
  }
}
