import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_callback/screenshot_callback.dart';

import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/presentation/providers/providers.dart';
import 'package:identidaddigital/core/utils/colors.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/auth/presentation/pages/login_page.dart';
import 'package:identidaddigital/features/digital_card/constants/tags.dart';
import 'package:identidaddigital/features/digital_card/presentation/bloc/digital_card_bloc.dart';
import 'package:identidaddigital/features/digital_card/presentation/pages/bar_code_full_page.dart';
import 'package:identidaddigital/features/digital_card/presentation/pages/qr_code_full_page.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/widgets.dart';

class DigitalCardPage extends StatefulWidget {
  /// Un-named route for [DigitalCardPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(builder: (context) => DigitalCardPage());
  }

  @override
  _DigitalCardPageState createState() => _DigitalCardPageState();
}

class _DigitalCardPageState extends State<DigitalCardPage>
    with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _carnet = GlobalKey<CarnetWidgetState>();
  final DigitalCardBloc _bloc = sl<DigitalCardBloc>();
  ScreenshotCallback screenshotCallback = ScreenshotCallback();

  PageController _profileController;
  int _activeProfileIndex = 0;
  bool _isFrontSideFocused = true;

  @override
  void initState() {
    super.initState();
    _profileController = PageController(initialPage: _activeProfileIndex);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermission();
      _requestNotificationPermission();
    });
    _bloc.turnOnScreenBrightness();
    screenshotCallback.addListener(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      _bloc.regenerateQR(userProvider.user);
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    _profileController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    screenshotCallback.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _refreshConfig();
      _regenerateQR();
      _requestPermission();
    }
    _bloc.qrGenerationPaused = state != AppLifecycleState.resumed;
  }

  void _startAccessCodeGeneration() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _bloc.startAccessCodeGeneration(userProvider.user);
  }

  Future<void> _refreshConfig() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await _bloc
        .updateQrPeriodicGenerationTimeWithRemoteConfig(userProvider.user);
  }

  void _regenerateQR() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _bloc.regenerateQR(userProvider.user);
  }

  Future<void> _requestPermission() async {
    final localizations = AppLocalizations.of(context);
    final result = await _bloc.updateUserPermission();
    result.fold(
      (failure) {
        if (failure is PermissionNotFoundFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Destinations.login,
            (route) => false,
            arguments: LoginReason(
              localizations.translate('session_expired'),
              localizations.translate('session_expired_error_message'),
            ),
          );
        }
      },
      (user) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.user = user;
      },
    );
  }

  Future<void> _requestNotificationPermission() {
    return FirebaseMessaging.instance.requestPermission();
  }

  void _handleBottomBarAction(int i) {
    switch (i) {
      case 0:
        AppNavigator.navigator.pushNamed(Destinations.settings);
        break;
      case 1:
        _flipCard();
        break;
      case 2:
        AppNavigator.navigator.pushNamed(Destinations.profilePicture);
        break;
      default:
        return;
    }
  }

  Future<bool> _preventPop() async {
    final isBackSideActive = await _carnet.currentState.maybeFlip();
    return !isBackSideActive;
  }

  void _flipCard() {
    _carnet.currentState.flip();
    if (!_isFrontSideFocused) {
      _startAccessCodeGeneration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _preventPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: ColoredBox(
          color: Colors.black,
          child: _buildBody(),
        ),
        bottomNavigationBar: BottomBar(
          onPressed: _handleBottomBarAction,
        ),
      ),
    );
  }

  Widget _buildBody() {
    final user = Provider.of<UserProvider>(context).user;
    final profiles = user.profiles;
    final profilesCount = profiles.length;
    final activeProfileIndex =
        _activeProfileIndex < profilesCount ? _activeProfileIndex : 0;
    final profile = profiles[activeProfileIndex];
    final ciu = profile.name.contains('ES') ? user.id : user.document;
    final barcode = user.id;

    return CarnetWidget(
      key: _carnet,
      onFlipped: (bool isFrontSideFocused) {
        _isFrontSideFocused = isFrontSideFocused;
      },
      onTap: _flipCard,
      front: FrontView(
        id: ciu,
        name: user.name,
        photo: user.picture,
        profileController: _profileController,
        profiles: user.profiles,
        profileColor: HexColor.tryParse(profile.colorHexStr),
        clockStream: _bloc.clockStream,
        showRolControllers: profilesCount > 1,
        onProfileChanged: (value) {
          _profileController?.dispose();
          setState(() {
            _activeProfileIndex = value;
            _profileController =
                PageController(initialPage: _activeProfileIndex);
          });
        },
        onNextProfile: () {
          _profileController.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        onPrevProfile: () {
          _profileController.previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
      back: StreamBuilder<String>(
        stream: _bloc.qrStream,
        builder: (context, snapshot) {
          return BackView(
            qrSnapshot: snapshot,
            barcode: barcode,
            label: kInstitutionTag,
            onBarcodePressed: () {
              Navigator.of(context).push(BarCodeFullPage.route(barcode));
            },
            onQrPressed: () {
              Navigator.of(context)
                  .push(QrCodeFullPage.route(_bloc, snapshot.data));
            },
            onBarcodeViewChanged: (value) {},
            onQrError: () => _bloc.regenerateQR(user),
          );
        },
      ),
    );
  }
}
