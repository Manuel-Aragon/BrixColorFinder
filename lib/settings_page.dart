import 'package:flutter/material.dart';
import 'package:lucky13capstone/register_page.dart';
import 'login_page.dart';
import 'package:lucky13capstone/about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucky13capstone/brickview_page.dart';
import 'package:lucky13capstone/dev_page.dart';
import 'settings_model.dart';
import 'package:provider/provider.dart';
import 'styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();

    // Call setState to trigger a rebuild
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(14),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _generalSettingsColumn(context),
              if (FirebaseAuth.instance.currentUser != null)
                _accountSettingsColumn()
              else
                const SizedBox(height: 0),
              if (FirebaseAuth.instance.currentUser != null)
                _securitySettingsColumn(context, this)
              else
                _securitySettingsColumnLoggedOut(context),
              _developmentSettingsColumn(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _generalSettingsColumn(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "General",
            style: headingStyle,
          ),
        ],
      ),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.table_chart_outlined),
          title: const Text("Brick View"),
          subtitle: const Text("View"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BrickView()),
            );
          }),
      const Divider(),
      const ThemeSwitcher(),
      const Divider(),
    ],
  );
}

Widget _accountSettingsColumn() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: headingStyle,
          ),
        ],
      ),
      const ListTile(
        leading: Icon(Icons.phone),
        title: Text("Phone Number"),
      ),
      const Divider(),
      const ListTile(
        leading: Icon(Icons.mail),
        title: Text("Email"),
      ),
      const Divider(),
    ],
  );
}

Widget _securitySettingsColumn(BuildContext context, _SettingsPageState state) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Security",
            style: headingStyle,
          ),
        ],
      ),
      const Divider(),
      const ListTile(
        leading: Icon(Icons.lock),
        title: Text("Change Password"),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text("Sign Out"),
        onTap: () => state._logout(context),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.save),
        title: const Text('Save Settings'),
        onTap: () {
          context.read<SettingsModel>().saveSettings();
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.save),
        title: const Text('Save to cloud'),
        onTap: () {
          context.read<SettingsModel>().saveToCloud();
        },
      ),
    ],
  );
}

Widget _securitySettingsColumnLoggedOut(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Security", style: headingStyle),
        ],
      ),
      ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Login"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }),
      const Divider(),
      ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text("Create Account"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          }),
    ],
  );
}

Widget _developmentSettingsColumn(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Development", style: headingStyle),
        ],
      ),
      ListTile(
        leading: const Icon(Icons.dangerous),
        title: const Text("Devevelopment Page"),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DevPage(title: 'Dev Page')),
        ),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text("About"),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        ),
      ),
    ],
  );
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the settings model
    final settings = context.watch<SettingsModel>();

    return SwitchListTile(
      title: const Text('Dark mode'),
      secondary: const Icon(Icons.brightness_medium),
      value: settings.darkMode,
      onChanged: (bool value) {
        // Update the dark mode value in the settings model
        context.read<SettingsModel>().updateDarkMode(value);
      },
    );
  }
}
