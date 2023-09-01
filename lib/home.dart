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
  TextEditingController passLengthController = TextEditingController();
  

  bool letters = true;
  bool numbers = false;
  bool special = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Random password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().secondaryColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      'Must contains',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants().primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: numbers,
                      onChanged: (value) {
                        setState(() {
                          numbers = !numbers;
                        });
                      },
                    ),
                    Text(
                      'Numbers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants().secondaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: special,
                      onChanged: (value) {
                        setState(() {
                          special = !special;
                        });
                      },
                    ),
                    Text(
                      'Special charecters',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants().secondaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 150),
                  child: TextField(
                    maxLength: 2,
                    controller: passLengthController,
                    decoration: InputDecoration(
                      label: const Text(
                        'Password length',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                      // hintText: 'Length of password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
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

                    final snackBar = SnackBar(
                      backgroundColor: ColorConstants().primaryColor,
                      content: const Text(
                        'Password copied',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  icon: Icon(
                    Icons.copy,
                    color: ColorConstants().primaryColor,
                  ),
                ),
                label: const Text(
                        'your password will shown here',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
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
        final password = generatePassword(
            hasLetters: letters,
            hasNumbers: numbers,
            hasSpecial: special,
            length: int.parse(passLengthController.text));
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
    int length = 12,
  }) {
    length = length;
    const letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const letterUpperCase = 'MNOPQRSTUVWXYZABCDEFGHIJKL';
    const numbers = '5678901234';
    const special = '@*~`^#=+!\$&%?{}()';

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
