import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

String formatoDate( String fecha) {
  if (fecha == null)
    return null;
  else
    return DateFormat("dd/MM/yyyy hh:mm aaa").format(DateTime.parse(fecha));
}

String formatoMoney(int money) {
  FlutterMoneyFormatter fo =
      FlutterMoneyFormatter(
         amount: money.toDouble(),
         settings: MoneyFormatterSettings(
                   fractionDigits: 0
         )
         );
 
    return fo.output.symbolOnLeft;
}
