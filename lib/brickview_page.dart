import 'package:flutter/material.dart';

class BrickView extends StatefulWidget {
  const BrickView({Key? key}) : super(key: key);

  @override
  State<BrickView> createState() => _BrickViewState();
}

class _BrickViewState extends State<BrickView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("BrickView"),
      ),
    );
  }
}
