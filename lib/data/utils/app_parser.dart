class AppParser {
  String formatTimeAgo(String dateString) {
    DateTime currentDate = DateTime.now();
    DateTime date = DateTime.parse(dateString);

    Duration difference = currentDate.difference(date);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years${years == 1 ? 'y' : 'y'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }
}
