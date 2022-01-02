import 'package:contribute/models/user.dart';
import 'package:contribute/presentation/screens/signin/signin_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  // static const padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    final user = UserModel(
      uid: firebaseUser?.uid,
      name: firebaseUser?.displayName,
      email: firebaseUser?.email,
      imageURL: firebaseUser?.photoURL,
    );
    return Drawer(
      child: Material(
        // color: ColorResources.DRAWER_BG,
        child: ListView(
          // padding: padding,
          children: [
            const SizedBox(height: 20),
            buildHeader(
              name: user.name,
              email: user.email,
              imgURL: user.imageURL,
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            // buildMenuItem(
            //   text: 'Profile',
            //   icon: Icons.account_circle,
            //   // onClicked: () => Navigator.pushNamed(context, '/'),
            // ),
            // buildMenuItem(
            //   text: 'My posted items',
            //   icon: Icons.format_list_bulleted,
            //   // onClicked: () => Navigator.pushNamed(context, '/'),
            //   onClicked: () {
            //     Navigator.pop(context);
            //     Navigator.pushNamed(context, '/my-items', arguments: user);
            //   },
            // ),
            buildMenuItem(
              text: 'Sign out',
              icon: Icons.logout_rounded,
              // onClicked: () => Navigator.pushNamed(context, '/'),
              onClicked: () {
                final provider =
                    Provider.of<SigninProvider>(context, listen: false);
                provider.logout();
                Navigator.pushNamed(context, '/home');
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String? imgURL,
    required String? name,
    required String? email,
  }) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imgURL!),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                ),
                const SizedBox(height: 4),
                Text(
                  email!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
