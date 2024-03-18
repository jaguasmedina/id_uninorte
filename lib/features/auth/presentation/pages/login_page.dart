import 'package:flutter/material.dart';
import 'package:identidaddigital/core/error/error.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/presentation/providers/providers.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/auth/presentation/bloc/login_bloc.dart';
import 'package:identidaddigital/features/auth/presentation/pages/change_external_password_page.dart';
import 'package:identidaddigital/features/auth/presentation/pages/device_already_registered_page.dart';
import 'package:identidaddigital/features/auth/presentation/pages/permission_not_found_page.dart';
import 'package:identidaddigital/features/auth/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/profile_picture/presentation/pages/picture_not_found_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginReason {
  final String title;
  final String subtitle;

  LoginReason(this.title, this.subtitle);
}

class LoginPage extends StatefulWidget {
  final LoginReason reason;

  const LoginPage({Key key, this.reason}) : super(key: key);

  /// Un-named route for [LoginPage].
  static Route route({LoginReason reason}) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => LoginPage(reason: reason),
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = sl<LoginBloc>();
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometrics();
      _showReason();
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _focusPassword() {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _showReason() {
    if (widget.reason != null) {
      DialogManager.showMessage(
        context: context,
        title: widget.reason.title,
        message: widget.reason.subtitle,
      );
    }
  }

  Future<void> _checkBiometrics() async {
    final shouldRequest = await _bloc.shouldRequestBiometricsAutomatically();
    if (shouldRequest && widget.reason == null) {
      _requestLocalAuth(context);
    }
  }

  Future<void> _requestLocalAuth(BuildContext context) async {
    FocusScope.of(context)
        .unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
    final localizations = AppLocalizations.of(context);
    final authenticated = await _bloc.authenticateWithBiometrics(localizations);

    if (!mounted) return;
    if (authenticated) {
      _login(useLastEntry: true);
    }
  }

  void _handleForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _login();
    }
  }

  Future<void> _login({bool useLastEntry = false}) async {
    FocusScope.of(context)
        .unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
    final localizations = AppLocalizations.of(context);
    DialogManager.showLoading(context: context);
    final result = await _bloc.login(useLastEntry: useLastEntry);
    AppNavigator.navigator.pop();
    result.fold(
      (failure) {
        if (failure is DeviceAlreadyInUseFailure) {
          Navigator.of(context).push<void>(DeviceAlreadyRegisteredPage.route());
        } else if (failure is PermissionNotFoundFailure) {
          Navigator.of(context).push<void>(PermissionNotFoundPage.route());
        } else if (failure is PictureNotFoundFailure) {
          Navigator.of(context).push<void>(PictureNotFoundPage.route());
        } else if (failure is NotAuthorizedFailure) {
          DialogManager.showMessage(
            context: context,
            title: localizations.translate('error_title'),
            message: localizations.translate(failure.key),
          );
        } else {
          DialogManager.showMessage(
            context: context,
            title: localizations.translate('error_title'),
            message: localizations.translate(failure.key),
          );
        }
      },
      (user) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.user = user;
        if (user.mustChangePassword) {
          Navigator.of(context).push(ChangeExternalPasswordPage.route());
        } else {
          AppNavigator.navigator.pushReplacementNamed(Destinations.carnet);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LoginBloc>(
        bloc: _bloc,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              const BackgroundImage(),
              _buildContent(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildLogo(),
                        _buildForm(context),
                      ],
                    ),
                  ),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const EntranceFader(
      offset: Offset(0.0, -32.0),
      delay: Duration(milliseconds: 300),
      child: LogoView(),
    );
  }

  Widget _buildForm(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildUserField(context),
            const SizedBox(height: 16.0),
            _buildPasswordField(context),
            const SizedBox(height: 16.0),
            _buildRecoverPassword(),
            const SizedBox(height: 6.0),
            _buildHelpRow(context),
            const SizedBox(height: 24.0),
            _buildActionsColumn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserField(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return EntranceFader(
      delay: const Duration(milliseconds: 450),
      child: GradientTextFormField(
        key: const Key('user_text_field'),
        // initialValue: ,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        hintText: localizations.translate('user_placeholder'),
        onSaved: _bloc.changeUsername,
        validator: (String value) {
          final result = _bloc.validateUsername(value);
          if (result == null) return result;
          return localizations.translate(result);
        },
        onFieldSubmitted: (_) {
          _focusPassword();
        },
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return EntranceFader(
      delay: const Duration(milliseconds: 600),
      child: GradientTextFormField(
        key: const Key('password_text_field'),
        obscureText: true,
        // initialValue: ,
        focusNode: _passwordFocusNode,
        textInputAction: TextInputAction.done,
        hintText: localizations.translate('password_placeholder'),
        validator: (String value) {
          final result = _bloc.validatePassword(value);
          if (result == null) return result;
          return localizations.translate(result);
        },
        onSaved: _bloc.changePassword,
      ),
    );
  }

  Widget _buildRecoverPassword() {
    return EntranceFader(
      delay: const Duration(milliseconds: 750),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(
            'https://sandia.uninorte.edu.co/sandi/solicitar_clave.php',
          ),
          mode: LaunchMode.externalApplication,
        ),
        child: Row(
          children: const [
            Text(
              'Olvidé mi contraseña',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpRow(BuildContext context) {
    return EntranceFader(
      delay: const Duration(milliseconds: 750),
      child: HelpRow(),
    );
  }

  Widget _buildActionsColumn(BuildContext context) {
    return EntranceFader(
      delay: const Duration(milliseconds: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildActionButtons(context).toList(),
      ),
    );
  }

  Iterable<Widget> _buildActionButtons(BuildContext context) sync* {
    final localizations = AppLocalizations.of(context);

    yield SolidButton(
      key: const Key('login_button'),
      title: localizations.translate('login_button'),
      onTap: _handleForm,
    );

    if (_bloc.canUseBiometrics) {
      yield Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SecondaryButton(
          title: localizations.translate('biometrics_button'),
          onPressed: () {
            _requestLocalAuth(context);
          },
        ),
      );
    }
  }

  Widget _buildFooter(BuildContext context) {
    return FittedBox(
      child: EntranceFader(
        delay: const Duration(milliseconds: 1050),
        child: Footer(),
      ),
    );
  }
}
