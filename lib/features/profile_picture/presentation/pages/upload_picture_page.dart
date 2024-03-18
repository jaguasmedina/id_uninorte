import 'dart:io';

import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/utils.dart' show DialogManager;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/upload_picture_bloc.dart';
import 'package:identidaddigital/features/profile_picture/presentation/widgets/widgets.dart';
import 'package:identidaddigital/di/injection.dart';

class UploadPicturePage extends StatefulWidget {
  final File picture;

  const UploadPicturePage({Key key, @required this.picture}) : super(key: key);

  /// Un-named route for [UploadPicturePage].
  static Route<T> route<T>(File file) {
    return MaterialPageRoute<T>(
      builder: (_) => UploadPicturePage(picture: file),
    );
  }

  @override
  _UploadPicturePageState createState() => _UploadPicturePageState();
}

class _UploadPicturePageState extends State<UploadPicturePage> {
  final _bloc = sl<UploadPictureBloc>();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<void> _uploadPicture() async {
    final localizations = AppLocalizations.of(context);
    DialogManager.showLoading(context: context);
    final result = await _bloc.uploadPicture(widget.picture);
    Navigator.of(context).pop();
    result.fold(
      (failure) {
        DialogManager.showMessage(
          context: context,
          title: localizations.translate('error_title'),
          message: localizations.translate(failure.key),
        );
      },
      (_) async {
        await DialogManager.showMessage(
          context: context,
          title: localizations.translate('picture_request_sent'),
          message: localizations.translate('picture_request_sent_successfully'),
        );
        Navigator.of(context).pop<bool>(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: SimpleAppBar(
        title: localizations.translate('cancel'),
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: ResponsiveBuilder(
        builder: (BuildContext context, ScreenType screenType) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: screenType.isMobile ? 0.5 : 0.4,
                child: UserCircleAvatar(
                  child: Image(
                    fit: BoxFit.cover,
                    image: FileImage(widget.picture),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
                width: double.infinity,
              ),
              TitleText(
                localizations.translate('profile_change_picture'),
              ),
              SubtitleText(
                localizations.translate('profile_change_picture_message'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SecondaryButton(
                  title: localizations.translate('send_picture'),
                  onPressed: _uploadPicture,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
