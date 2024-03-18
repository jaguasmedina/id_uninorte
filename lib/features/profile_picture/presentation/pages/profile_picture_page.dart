import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/providers/providers.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/utils/utils.dart'
    show DialogManager, MyIcons;
import 'package:identidaddigital/features/profile_picture/presentation/bloc/profile_picture_bloc.dart';
import 'package:identidaddigital/features/profile_picture/presentation/widgets/widgets.dart';
import 'package:identidaddigital/di/injection.dart';

class ProfilePicturePage extends StatefulWidget {
  /// Un-named route for [ProfilePicturePage].
  static Route route() {
    return SlideUpRoute<dynamic>(ProfilePicturePage());
  }

  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  final _bloc = sl<ProfilePictureBloc>();

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

  Future<void> _requestPictureStatus() async {
    DialogManager.showLoading(
      context: context,
      title: getString(context, 'obtaining_info'),
    );
    await _bloc.requestPictureStatus();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _uploadPicture() async {
    final localizations = AppLocalizations.of(context);
    final result = await _bloc.uploadPicture();
    if (!mounted) return;
    result.fold(
      (failure) {
        DialogManager.showMessage(
          context: context,
          title: localizations.translate('error_title'),
          message: localizations.translate(failure.key),
        );
      },
      (_) {
        DialogManager.showMessage(
          context: context,
          title: localizations.translate('picture_request_sent'),
          message: localizations.translate('picture_request_sent_successfully'),
        );
      },
    );
  }

  IconData _getIndicatorIcon(PictureStatus status) {
    if (status.isPending) {
      return MyIcons.time;
    } else if (status.isRejected) {
      return MyIcons.info;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: UserAppBar(
        onLeadingPressed: () => AppNavigator.navigator.pop(),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PictureCard(
                        imageUrl: userProvider.user.picture,
                        imageFile: _bloc.selectedFile,
                        isUploading: state == PageState.busy,
                        onUpload: _uploadPicture,
                        icon: _getIndicatorIcon(_bloc.pictureStatus),
                      ),
                      const SizedBox(width: double.infinity, height: 8.0),
                      TitleText(
                        getString(context, 'profile_change_picture'),
                      ),
                      _buildSatusMessage(),
                      const PictureFeaturesView(),
                    ],
                  ),
                ),
                _buildButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSatusMessage() {
    final status = _bloc.pictureStatus;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: status.isEmpty ? Container() : SubtitleText(status.message),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SecondaryButton(
        onPressed: _bloc.selectFile,
        title: getString(context, 'profile_upload_button'),
      ),
    );
  }
}
