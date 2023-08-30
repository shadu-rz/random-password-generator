import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_password/constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Secure password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants().primaryColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Random Secure password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants().secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    final data = ClipboardData(text: controller.text);
                    Clipboard.setData(data);
                  },
                  icon: const Icon(Icons.copy),
                ),
                hintText: 'your password will shown here',
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants().primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstants().primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final backgroundColor = MaterialStateColor.resolveWith(
      (states) => states.contains(MaterialState.pressed)
          ? ColorConstants().secondaryColor
          : ColorConstants().primaryColor,
    );
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: backgroundColor),
      onPressed: () {
        final password = generatePassword();
        controller.text = password;
      },
      child: const Text(
        'Generate password',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  String generatePassword({
    bool hasLetters = true,
    bool hasNumbers = true,
    bool hasSpecial = true,
  }) {
    const length = 10;
    const letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const letterUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const special = '@#=+!\$&%?{}()';

    String chars = '';
    if (hasLetters) chars += '$letterLowerCase$letterUpperCase';
    if (hasNumbers) chars += numbers;
    if (hasSpecial) chars += special;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
