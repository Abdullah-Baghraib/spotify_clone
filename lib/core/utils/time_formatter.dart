class TimeFormatter {
  /// Formats duration in seconds to "mm:ss" format
  static String formatDuration(int durationInSeconds) {
    final minutes = (durationInSeconds / 60).floor();
    final seconds = durationInSeconds % 60;
    
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Returns greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
} 