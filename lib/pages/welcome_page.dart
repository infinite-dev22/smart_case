import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_case/services/apis/auth_apis.dart';
import 'package:smart_case/theme/color.dart';
import 'package:smart_case/widgets/auth_text_field.dart';
import 'package:smart_case/widgets/custom_icon_holder.dart';
import 'package:smart_case/widgets/custom_images/custom_image.dart';
import 'package:smart_case/widgets/wide_button.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/smart_case_init.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ToastContext toast = ToastContext();

  bool isAuthingUser = true;
  bool showLogin = true;
  bool isSendingResetRequest = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    toast.init(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImage(
                "assets/images/splash.png",
                trBackground: true,
                isNetwork: false,
                width: MediaQuery.of(context).size.width * .6,
                imageFit: BoxFit.contain,
                radius: 0,
              ),
              const SizedBox(height: 40),
              (showLogin) ? _buildLoginBody() : _buildPasswordResetBody(),
              const SizedBox(height: 10),
              _buildTextWithLink('contact us: ', 'info@infosectechno.com'),
              const SizedBox(height: 8),
              _buildTextWithAction('+256 (0)770456789'),
              const SizedBox(height: 8),
              Text(
                'copyright @ ${DateTime.now().year} SmartCase Manager',
                style: const TextStyle(
                  color: AppColors.inActiveColor,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildTextWithLink(String data, String link) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: data,
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: AppColors.white),
              ),
              TextSpan(
                text: link,
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                    color: AppColors.white),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl(Uri(
                      scheme: "mailto",
                      path: "info@infosectechno.com",
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Infosec Technologies Info mail',
                      }),
                    ));
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildTextWithAction(String data) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: data,
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                    color: AppColors.white),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    await FlutterPhoneDirectCaller.callNumber('+256770456789');
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _onPressed() {
    if (EmailValidator.validate(
        currentUserEmail != '' && currentUserEmail != null
            ? currentUserEmail!
            : emailController.text)) {
      setState(() {
        isAuthingUser = false;
      });

      AuthApis.signInUser(
          currentUserEmail != '' && currentUserEmail != null
              ? currentUserEmail!
              : emailController.text.trim(),
          passwordController.text.trim(),
          onSuccess: _signUserIn,
          onNoUser: _handleWrongEmail,
          onWrongPassword: _handleWrongPass,
          onError: _handleError,
          onErrors: _handleErrors);
    } else {
      Toast.show("Email not valid",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    }
  }

  _onResetPressed() {
    if (EmailValidator.validate(emailController.text.trim())) {
      setState(() {
        isSendingResetRequest = false;
      });

      AuthApis.requestReset(
        'api/password/email',
        onError: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Toast.show("An error occurred",
              duration: Toast.lengthLong, gravity: Toast.bottom);

          setState(() {
            isSendingResetRequest = false;
            showLogin = false;
          });
        },
        onSuccess: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Toast.show("Reset password link sent on your email",
              duration: Toast.lengthLong, gravity: Toast.bottom);
          setState(() {
            isSendingResetRequest = true;
            showLogin = true;
          });
        },
      );
    } else {
      Toast.show("Email not valid",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    }
  }

  _signUserIn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, '/root');

    await storage.write(key: 'email', value: emailController.text.trim());
    await storage.write(key: 'name', value: currentUser.firstName);
    await storage.write(key: 'image', value: currentUser.avatar);
  }

  _handleWrongEmail() {
    Toast.show("User not found",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    setState(() {
      isAuthingUser = true;
    });
  }

  _handleErrors(e) {
    Toast.show(e.toString(), duration: Toast.lengthLong, gravity: Toast.bottom);
    setState(() {
      isAuthingUser = true;
    });
  }

  _handleWrongPass() {
    Toast.show("Incorrect password",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    setState(() {
      isAuthingUser = true;
    });
  }

  _handleError() {
    Toast.show("An error occurred",
        duration: Toast.lengthLong, gravity: Toast.bottom);
    setState(() {
      isAuthingUser = true;
    });
  }

  _getCurrentUserData() async {
    String? email = await storage.read(key: 'email');
    String? name = await storage.read(key: 'name');
    String? image = await storage.read(key: 'image');
    String? fcmToken = await storage.read(key: 'fcmToken');

    setState(() {
      currentUserEmail = email;
      currentUsername = name;
      currentUserImage = image;
      currentUserFcmToken = fcmToken;
    });
  }

  _buildPasswordResetBody() {
    return Column(
      children: [
        const Text(
          'A Password reset link will be sent to the email entered below, '
          'click Proceed to continue',
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        const SizedBox(height: 20),
        AuthTextField(
          controller: emailController,
          hintText: 'email',
          enabled: isAuthingUser,
          obscureText: false,
          isEmail: true,
          style: const TextStyle(color: AppColors.white),
          borderSide: const BorderSide(color: AppColors.white),
          fillColor: AppColors.primary,
        ),
        const SizedBox(height: 10),
        _buildButtons(),
      ],
    );
  }

  _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => AppColors.gray45),
            ),
            onPressed: () {
              setState(() {
                isSendingResetRequest = false;
                showLogin = true;
              });
            },
            alignment: Alignment.center,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.gray45),
              fixedSize:
                  Size.fromWidth(MediaQuery.of(context).size.width * .75),
            ),
            onPressed: _onResetPressed,
            child: isSendingResetRequest
                ? const Text(
                    'Proceed',
                    style: TextStyle(color: AppColors.gray45, fontSize: 20),
                  )
                : const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: AppColors.gray45,
                      strokeWidth: 2,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _buildLoginBody() {
    return Column(
      children: [
        Text(
          (currentUsername != null)
              ? 'Welcome, ${currentUsername!}'
              : 'Welcome',
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.w100),
        ),
        const SizedBox(
          height: 30,
        ),
        (currentUserEmail == null || currentUserEmail == '')
            ? AuthTextField(
                controller: emailController,
                hintText: 'email',
                enabled: isAuthingUser,
                obscureText: false,
                isEmail: true,
                style: const TextStyle(color: AppColors.gray45),
                borderSide: const BorderSide(color: AppColors.gray45),
                fillColor: AppColors.primary,
              )
            : currentUserImage != null
                ? CustomImage(currentUserImage)
                : const CustomIconHolder(
                    width: 120,
                    height: 120,
                    graphic: Icons.account_circle,
                    bgColor: AppColors.white,
                    radius: 90,
                    size: 135,
                    isProfile: true,
                  ),
        const SizedBox(
          height: 20,
        ),
        AuthPasswordTextField(
          controller: passwordController,
          hintText: 'password',
          enabled: isAuthingUser,
          borderSide: const BorderSide(color: AppColors.gray45),
          style: const TextStyle(color: AppColors.gray45),
          fillColor: AppColors.primary,
          iconColor: AppColors.gray45,
        ),
        const SizedBox(
          height: 10,
        ),
        (isAuthingUser)
            ? WideButton(
                name: 'Login',
                onPressed: _onPressed,
                bgColor: AppColors.gray45,
                textStyle:
                    const TextStyle(color: AppColors.primary, fontSize: 20),
              )
            : const CircularProgressIndicator(
                color: AppColors.gray45,
              ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              showLogin = false;
            });
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _getCurrentUserData();
    super.initState();
  }
}
