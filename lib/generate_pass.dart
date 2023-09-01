import 'dart:math';

class GeneratePass {
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