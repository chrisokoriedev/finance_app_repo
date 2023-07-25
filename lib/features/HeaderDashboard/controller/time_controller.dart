import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Greeting {
  morning,
  afternoon,
  evening,
}

final greetingProvider = StateProvider<Greeting>((ref) {
  final currentTime = DateTime.now().hour;

  if (currentTime < 12) {
    return Greeting.morning;
  } else if (currentTime < 17) {
    return Greeting.afternoon;
  } else {
    return Greeting.evening;
  }
});