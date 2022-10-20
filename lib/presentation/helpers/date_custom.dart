import 'package:intl/intl.dart';

class DateCustom {
  static String getDateFrave() {
    int time = DateTime.now().hour;

    if (time < 12)
      return 'Bom Dia';
    else if (time > 12 && time < 18)
      return 'Boa Tarde';
    else if (time < 24 && time > 18)
      return 'Boa Noite';
    else
      return 'Olá!';
  }

  static String getDateOrder(String date) {
    var newStr = date.substring(0, 10) + ' ' + date.substring(11, 23);

    DateTime dt = DateTime.parse(newStr);
    return DateFormat("EEE, d MMM  yyyy HH:mm:ss").format(dt);
  }
}
