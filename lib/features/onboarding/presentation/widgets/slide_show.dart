import 'package:flutter/material.dart';

import 'package:identidaddigital/features/onboarding/presentation/widgets/slide_indicator.dart';

class SlideShow extends StatefulWidget {
  final List<Widget> slides;
  final VoidCallback onSkipped;
  final VoidCallback onDone;

  const SlideShow({
    Key key,
    @required this.slides,
    this.onSkipped,
    this.onDone,
  }) : super(key: key);

  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final _controller = PageController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page.round() >= widget.slides.length - 1) {
        // _isCompleted = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _nextSlide() {
  //   _controller.animateToPage(
  //     _controller.page.round() + 1,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.ease,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                children: widget.slides,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return SlideIndicator(
                  currentSlide: _controller.page ?? 0,
                  length: widget.slides.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
