import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:identidaddigital/core/domain/entities/faq.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/utils.dart';

class FaqItemView extends StatefulWidget {
  final Faq faq;

  const FaqItemView(
    this.faq, {
    Key key,
  }) : super(key: key);

  @override
  _FaqItemViewState createState() => _FaqItemViewState();
}

class _FaqItemViewState extends State<FaqItemView> {
  var _isExpanded = false;

  void _toggle() {
    _isExpanded = !_isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TweenAnimationBuilder<double>(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        tween: Tween(begin: 0.0, end: _isExpanded ? 1.0 : 0.0),
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TitleRow(
                title: widget.faq.title,
                iconAngle: value * pi,
                onTap: _toggle,
              ),
              ClipRect(
                child: Align(
                  heightFactor: value,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _ContentText(widget.faq.content),
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final String title;
  final double iconAngle;
  final VoidCallback onTap;

  const _TitleRow({
    Key key,
    @required this.title,
    @required this.iconAngle,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoFeedbackButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Transform.rotate(
              angle: iconAngle,
              child: const Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentText extends StatelessWidget {
  final String text;

  const _ContentText(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Linkify(
      text: text,
      linkStyle: theme.textTheme.bodyText2.copyWith(
        color: theme.accentColor,
      ),
      onOpen: (link) {
        IntentManager.launchUrl(link.url);
      },
    );
  }
}
