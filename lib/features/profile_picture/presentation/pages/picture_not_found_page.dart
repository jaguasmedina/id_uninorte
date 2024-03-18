import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/utils.dart'
    show MyIcons, DialogManager;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/picture_not_found_bloc.dart';
import 'package:identidaddigital/features/profile_picture/presentation/pages/upload_picture_page.dart';
import 'package:identidaddigital/features/profile_picture/presentation/widgets/widgets.dart';
import 'package:identidaddigital/di/injection.dart';

class PictureNotFoundPage extends StatefulWidget {
  /// Un-named route for [PictureNotFoundPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(builder: (_) => PictureNotFoundPage());
  }

  @override
  _PictureNotFoundPageState createState() => _PictureNotFoundPageState();
}

class _PictureNotFoundPageState extends State<PictureNotFoundPage> {
  final _bloc = sl<PictureNotFoundBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPictureStatus();
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _logout() {
    Navigator.of(context).pop();
  }

  Future<void> _requestPictureStatus() async {
    DialogManager.showLoading(
      context: context,
      title: getString(context, 'obtaining_info'),
    );
    await _bloc.requestPictureStatus();
    Navigator.of(context).pop();
  }

  Future<void> _selectPicture() async {
    final success = await _bloc.selectFile();
    if (success) {
      final pictureWasUploaded = await Navigator.of(context).push<bool>(
            UploadPicturePage.route<bool>(_bloc.selectedFile),
          ) ??
          false;
      if (pictureWasUploaded) {
        _bloc.updatePictureStatusToPending();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIcon(context),
                const SizedBox(height: 22.0, width: double.infinity),
                _buildTitle(context),
                const SizedBox(height: 16.0),
                _buildSubtitle(context),
                const SizedBox(height: 8.0),
                const PictureFeaturesView(widthFactor: 0.9),
                const SizedBox(height: 24.0),
                SecondaryButton(
                  title: getString(context, 'select_picture'),
                  onPressed: _selectPicture,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return SimpleAppBar(
      title: getString(context, 'back'),
      icon: Icons.arrow_back,
      onTap: _logout,
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      MyIcons.capture,
      color: Theme.of(context).accentColor,
      size: 100.0,
    );
  }

  Widget _buildTitle(BuildContext context) {
    String title = getString(context, 'picture_not_found_title');
    if (_bloc.pictureStatus.isPending) {
      title = 'Solicitud de cambio de foto en proceso.';
    } else if (_bloc.pictureStatus.isRejected) {
      title = 'Solicitud de cambio de foto rechazada.';
    }
    return TitleText(title);
  }

  Widget _buildSubtitle(BuildContext context) {
    String message = getString(context, 'picture_not_found_message');
    if (!_bloc.pictureStatus.isEmpty) {
      message = _bloc.pictureStatus.message;
    }
    return SubtitleText(message);
  }
}
