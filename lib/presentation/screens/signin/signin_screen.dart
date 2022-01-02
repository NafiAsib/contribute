import 'package:contribute/core/utils/notifier_state.dart';
import 'package:contribute/presentation/screens/signin/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SigninProvider>(builder: (context, value, child) {
        if (value.notifierState == NotifierState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Text(
                //   'Contr!bute',
                //   style: TextStyle(fontSize: 60),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset('assets/main-logo.png'),
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    final provider =
                        Provider.of<SigninProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/google-icon.svg',
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF261C2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40), // <-- Radius
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
