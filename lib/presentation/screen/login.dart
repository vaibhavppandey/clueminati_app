import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clueminati_app/presentation/screen/base_screen.dart';
import 'package:clueminati_app/presentation/components/frosted_text_field.dart';
import 'package:clueminati_app/services/firebase_service.dart';

import 'package:clueminati_app/constants/assets.dart' as assets;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      sprite: assets.hi,
      spriteAlignment: Alignment.bottomRight,
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Login",
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: kClueMinatiWhite),
          ),
          const SizedBox(height: 32),
          // Email textfield
          FrostedTextField(
            label: "Email",
            controller: _emailController,
          ),
          const SizedBox(height: 24),
          // Pasword textfield
          FrostedTextField(
            label: "Password",
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 48),
          // Login button
          Consumer<FirebaseAppNotifier>(
            builder: (context, notifier, _) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 72),
              ),
              onPressed: pressed ||
                      _emailController.text.isEmpty ||
                      _passwordController.text.isEmpty
                  ? null
                  : () {
                      _onLogin(notifier);
                      setState(() => pressed = true);
                    },
              child: pressed
                  ? const SizedBox.square(
                      dimension: 28, child: CircularProgressIndicator())
                  : const Text("LOGIN"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onLogin(FirebaseAppNotifier notifier) async {
    await notifier.loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (notifier.loggedIn) {
      Future.microtask(
          () => Navigator.of(context).pushReplacementNamed('/home'));
    } else {
      _showAlertDialog();
    }
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      useSafeArea: false,
      barrierColor: Colors.black.withOpacity(.95),
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('WRONG CREDENTIALS'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Something went wrong'),
                Text('Contact firebase guys if issue persists'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Alr'),
              onPressed: () {
                setState(() => pressed = false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
