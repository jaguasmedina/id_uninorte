import 'dart:io';

import 'package:flutter/material.dart';

import 'package:identidaddigital/core/extensions/size_extension.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class PictureCard extends StatelessWidget {
  final String imageUrl;
  final File imageFile;
  final bool isUploading;
  final VoidCallback onUpload;
  final IconData icon;

  const PictureCard({
    Key key,
    this.imageUrl,
    this.imageFile,
    this.onUpload,
    this.icon,
    this.isUploading = false,
  }) : super(key: key);

  void _upload() {
    if (!isUploading && onUpload != null) {
      onUpload();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final children = <Widget>[
      SizedBox(
        width: size.width * (size.isMobile ? 0.5 : 0.4),
        child: UserCircleAvatar(
          child: _buildImage(context),
        ),
      ),
      if (icon != null)
        Positioned(
          top: -20.0,
          right: -20.0,
          child: Icon(
            icon,
            size: 40.0,
            color: theme.accentColor,
          ),
        )
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: children,
    );
  }

  Widget _buildImage(BuildContext context) {
    Widget imageChild;
    if (imageFile != null) {
      imageChild = _buildImageToUpload(context);
    } else if (imageUrl != null) {
      imageChild = CustomNetworkImage(
        fit: BoxFit.cover,
        data: imageUrl,
      );
    } else {
      imageChild = const Placeholder();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      layoutBuilder: (Widget currentChild, List<Widget> previousChildren) {
        return Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: imageChild,
    );
  }

  Widget _buildImageToUpload(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return NoFeedbackButton(
      onTap: _upload,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            image: FileImage(imageFile),
          ),
          Container(
            color: Colors.black38,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isUploading)
                    const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else
                    const Icon(
                      Icons.file_upload,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  Text(
                    localizations.translate('send').toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
