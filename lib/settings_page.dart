import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucky13capstone/brickview_page.dart';
import 'package:lucky13capstone/dev_page.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'settings_model.dart';
import 'package:provider/provider.dart';
import 'styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
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
              const ListTile(
                leading: Icon(Icons.cloud),
                title: Text("History"),
                subtitle: Text("Settings"),
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.table_chart_outlined),
                  title: const Text("Brick View"),
                  subtitle: const Text("View"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrickView()),
                    );
                  }),
              const ThemeSwitcher(),
              _accountSettings(context: context),
              const Divider(),
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
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }),
              const ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Sign Out"),
                onTap: () => _logout(),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Save Settings'),
                onTap: () {
                  context.read<SettingsModel>().saveSettings();
                },
              ),
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
            ],
          ),
        ),
      ),
    );
  }
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

        // if (value) {
        //   AdaptiveTheme.of(context).setThemeMode(AdaptiveThemeMode.dark);
        // } else {
        //   AdaptiveTheme.of(context).setThemeMode(AdaptiveThemeMode.light);
        // }
      },
    );
  }
}

Widget _accountSettings({
  required BuildContext context,
}) {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Account", style: headingStyle),
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
  ]);
}
