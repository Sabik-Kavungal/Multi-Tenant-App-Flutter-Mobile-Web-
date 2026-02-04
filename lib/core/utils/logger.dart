/// Simple logger utility
/// Can be replaced with a proper logging package if needed
class Logger {
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    // In production, this can be disabled or sent to a logging service
    print('[DEBUG] $message');
    if (error != null) {
      print('[ERROR] $error');
      if (stackTrace != null) {
        print('[STACK] $stackTrace');
      }
    }
  }

  static void info(String message) {
    print('[INFO] $message');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    print('[ERROR] $message');
    if (error != null) {
      print('[ERROR DETAIL] $error');
      if (stackTrace != null) {
        print('[STACK] $stackTrace');
      }
    }
  }
}
