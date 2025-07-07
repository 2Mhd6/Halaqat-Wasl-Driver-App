import 'package:easy_localization/easy_localization.dart';

class DateMethod {
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) return tr('date.not_set');
    return '${getDayName(dateTime.weekday)}\n${dateTime.day}, ${getMonthName(dateTime.month)}';
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return tr('time.not_set');

    final saTime = dateTime.add(const Duration(hours: 3));

    final hour = saTime.hour % 12 == 0 ? 12 : saTime.hour % 12;
    final minute = saTime.minute.toString().padLeft(2, '0');
    final period = saTime.hour >= 12 ? 'PM' : 'AM';

    final localizedPeriod = tr('time.${period.toLowerCase()}'); 

    return '$hour:$minute $localizedPeriod';
  }

  static String getDayName(int weekday) {

    const keys = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
    return tr('days.${keys[weekday - 1]}');
  }

  static String getMonthName(int month) {
  
    const keys = [
      'jan', 'feb', 'mar', 'apr', 'may', 'jun',
      'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
    ];
    return tr('months.${keys[month - 1]}');
  }
}
