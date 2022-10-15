// make a funtion that format the string
String formatString(String str) {
  return str
      .replaceAll(' ', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('-', '')
      .replaceAll('!', '')
      .replaceAll('?', '')
      .replaceAll(':', '')
      .replaceAll(';', '')
      .replaceAll('.', '')
      .replaceAll(',', '')
      .toLowerCase();
}
