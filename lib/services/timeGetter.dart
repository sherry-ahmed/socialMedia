

class Timegetter {
  static String formatTimestamp(String timestamp) {
  // Convert the string timestamp to an integer
  int millis = int.parse(timestamp);

  // Convert the milliseconds to a DateTime object
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
  DateTime now = DateTime.now();

  // Check if it's today
  if (_isSameDay(dateTime, now)) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  // Check if it's yesterday
  DateTime yesterday = now.subtract(const Duration(days: 1));
  if (_isSameDay(dateTime, yesterday)) {
    return "Yesterday";
  }

  // Check if it's within the last 7 days
  if (now.difference(dateTime).inDays < 7) {
    return _getDayOfWeek(dateTime.weekday);
  }

  // If it's older than a week, return the full date
  return "${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}";
}

// Helper function to check if two dates are on the same day
static bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

// Helper function to get the day of the week
static String _getDayOfWeek(int day) {
  switch (day) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "";
  }
}

// Helper function to get the month name
static String _getMonthName(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 4) {
      return "Still Wakeup";
    }
    else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
    

}