import 'package:intl/intl.dart';

class AppUtil {
  static const dateTimeMMMDYHHMMA = "MMM d, y hh:mm a";
  static const dateTimeMMMDHHMMA = "MMM d, hh:mm a";
  static const dateTimeDDMMMMYYYY = "dd MMMM yyyy";
  static const dateTimeDDMMYYYY = "dd-MM-yyyy";
  static const dateTimeMMMDY = "MMM d, y";
  static const dateTimeYYYYMM = "yyyy-MM";
  static const dateTimeMMMDthYYYYHHMMA = "MMMM d'th' yyyy hh:mm a";
  static const dateTimeMMMDthYYYY = "MMMM d'th' yyyy";
  static const dateTimeDDMMYYYYdob = "dd/MM/yyyy";
  static const dateTimeYYYYMMDDTHHMMSS = "yyyyMMddThhmmss";
  static const dateTimeMciISO = "YYYY-MM-DDTHH:MM:SSZ";
  static const mmm = "MMM";
  static const dd = "dd";
  static const EEEE = "EEEE";
  static const hhmma = "hh:mm a";

  static String getMMMDYDateFormat(String? input) {
    String output = "";
    try {
      if (input != null) {
        DateTime parseDate = DateTime.parse(input);
        final DateFormat dateFormatter = DateFormat("MMM d, y");
        output = dateFormatter.format(parseDate);
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String getYYYYMMDDDateFormat(String? input) {
    String output = "";
    try {
      if (input != null) {
        DateTime parseDate = DateTime.parse(input);
        final DateFormat dateFormatter = DateFormat("yyyy, M, dd");
        output = dateFormatter.format(parseDate);
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String convertDateTimeToMMMDYDateFormat(DateTime? input) {
    String output = "";
    try {
      if (input != null) {
        final DateFormat dateFormatter = DateFormat("MMM d, y");
        output = dateFormatter.format(input.toLocal());
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String getTimeHHMMA(String? input) {
    String output = "";
    try {
      if (input != null) {
        DateTime parseDate = DateTime.parse(input);
        final DateFormat dateFormatter = DateFormat("hh:mm a");
        output = DateFormat().add_jm().format(parseDate.toLocal());
        //output=dateFormatter.format(parseDate);
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String convertDateTimeToMMMDYHHMMADateFormat(String? input) {
    String output = "";
    try {
      if (input != null) {
        DateTime parseDate = DateTime.parse(input);
        final DateFormat dateFormatter = DateFormat("MMM d, y hh:mm a");
        output = dateFormatter.format(parseDate);
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String convertStringToDateFormat(String? input,
      {String format = dateTimeMMMDYHHMMA}) {
    String output = "";
    try {
      if (input != null) {
        DateTime parseDate = DateTime.parse(input);
        final DateFormat dateFormatter = DateFormat(format);
        output = dateFormatter.format(parseDate.toLocal());
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static String convertTimeStampToDateFormat(String? input,
      {String format = dateTimeMMMDYHHMMA}) {
    String output = "";
    try {
      if (input != null) {
        var millisecond = int.parse(input);
        DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(millisecond);
        final DateFormat dateFormatter = DateFormat(format);
        output = dateFormatter.format(parseDate);
      }
    } catch (e) {
      print(e);
      return output;
    }
    return output;
  }

  static int getValidateDays(String? time) {
    int validateDays = 0;
    try {
      if (time != null && time.isNotEmpty) {
        int validateTime = int.parse(time);
        validateDays = validateTime / 1000 / 60 / 60 ~/ 24;
      }
    } catch (e) {
      print(e);
    }
    return validateDays;
  }

  static String getCurrentDate({String format = dateTimeMMMDYHHMMA}) {
    final now = DateTime.now();
    String currentDate = DateFormat(format).format(now);
    return currentDate;
  }

  static bool isAdult(String birthDateString) {
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(dateTimeMMMDY).parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );
    return adultDate.isBefore(today);
  }

  static bool is24HoursLeft(String? sessionDate) {
    bool is24HoursLeft = false;
    try {
      DateTime today = DateTime.now();
      DateTime sessionTime = DateTime.parse(sessionDate!);
      int hours = sessionTime.difference(today).inHours;
      if (hours <= 24) {
        is24HoursLeft = true;
      }
    } catch (e) {
      print(e);
    }
    return is24HoursLeft;
  }

  static String convertNumberToReadableFormat(int number)
  {
    var formatNumber="";
    if(number<1000)
      {
         if(number==0)
           {
             formatNumber = "";
           }
         else
           {
             formatNumber = "$number";
           }
      }
    else
      {
        formatNumber = NumberFormat.compactCurrency(
          decimalDigits: 2,
          symbol: '', // if you want to add currency symbol then pass that in this else leave it empty.
        ).format(number);
      }
    print(formatNumber);
    return formatNumber;
  }

  static String getTimeAgo(String inputTime)
  {
    String agoTime = "";

    if(inputTime.isNotEmpty)
      {
        int time=int.parse(inputTime);

        final diff = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(time));
        if (diff.inDays > 365) {
          return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
        }
        if (diff.inDays > 30) {
          return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
        }
       /* if (diff.inDays > 7) {
          return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
        }*/
        if (diff.inDays > 0) {
          return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
        }
        if (diff.inHours > 0) {
          return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
        }
        if (diff.inMinutes > 0) {
          return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
        }
        return "just now";
      }
    return agoTime;
  }
}
