import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  double turns = 0.0;

  void _changeRotation() {
    setState(() => turns += 1.0 / 30);
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _changeRotation,
            child: Text(
              "Rotate",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          AnimatedRotation(
            turns: turns,
            duration: Duration(seconds: 1),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/tasbeh_bg.png",
                  width: 300,
                  height: 300,
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
