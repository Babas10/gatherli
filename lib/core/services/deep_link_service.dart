// Abstract service for handling deep links and extracting invite tokens
// or shareable-activity-link targets (game/training session/championship match).
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';

abstract class DeepLinkService {
  Stream<String?> get inviteTokenStream;
  Future<String?> getInitialInviteToken();
  Stream<ActivityLinkTarget?> get activityLinkStream;
  Future<ActivityLinkTarget?> getInitialActivityLink();
  void dispose();
}
