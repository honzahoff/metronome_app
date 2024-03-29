import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/session.dart';
import '../session_controller.dart';

// Provides SessionController
final sessionControllerProvider =
    StateNotifierProvider<SessionController, Session?>((ref) {
  return SessionController();
});
