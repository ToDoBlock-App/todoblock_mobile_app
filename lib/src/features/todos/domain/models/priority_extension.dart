export 'priority_extension.dart';

enum Priority {
  MUST_HAVE,
  SHOULD_HAVE,
  COULD_HAVE,
  WONT_HAVE
}

extension IntToPriority on int{
  Priority toPriority() {
    switch(this){
      case 0:
        return Priority.WONT_HAVE;
      case 1:
        return Priority.COULD_HAVE;
      case 2:
        return Priority.SHOULD_HAVE;
      case 3:
        return Priority.MUST_HAVE;
      default:
        return Priority.WONT_HAVE;
    }
  }
}

extension PriorityToInt on Priority {
  int toInt() {
    switch (this) {
      case Priority.WONT_HAVE:
        return 0;
      case Priority.COULD_HAVE:
        return 1;
      case Priority.SHOULD_HAVE:
        return 2;
      case Priority.MUST_HAVE:
        return 3;
      default:
        return -1; // Or any other default value you see fit
    }
  }
}