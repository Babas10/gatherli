// Determines whether a user is eligible to register for a championship.
// Extracted from championship_detail_page.dart where it was inline logic.
import 'package:play_with_me/core/domain/use_cases/base_use_case.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';

class ChampionshipEligibilityInput {
  final ChampionshipModel championship;
  final List<ChampionshipTeamModel> teams;
  final String? userId;
  final String? userGender;

  const ChampionshipEligibilityInput({
    required this.championship,
    required this.teams,
    this.userId,
    this.userGender,
  });
}

class ChampionshipEligibilityResult {
  final bool isAlreadyRegistered;
  final bool isGenderAllowed;
  final bool canRegister;
  final String? genderBlockReason;
  final String? myTeamId;

  const ChampionshipEligibilityResult({
    required this.isAlreadyRegistered,
    required this.isGenderAllowed,
    required this.canRegister,
    this.genderBlockReason,
    this.myTeamId,
  });
}

class CheckChampionshipEligibilityUseCase
    extends UseCase<ChampionshipEligibilityInput, ChampionshipEligibilityResult> {

  const CheckChampionshipEligibilityUseCase();

  @override
  Future<ChampionshipEligibilityResult> execute(
    ChampionshipEligibilityInput input,
  ) async {
    final userId = input.userId;
    final championship = input.championship;
    final teams = input.teams;

    final isAlreadyRegistered = userId != null &&
        teams.any((t) => t.memberIds.contains(userId));

    final isGenderAllowed = _isGenderAllowed(
      championship.genderCategory,
      input.userGender,
    );

    final canRegister = userId != null &&
        !isAlreadyRegistered &&
        isGenderAllowed &&
        championship.status == ChampionshipStatus.registration &&
        championship.isOpen;

    final myTeamId = userId != null
        ? teams
            .where((t) => t.memberIds.contains(userId))
            .map((t) => t.id)
            .firstOrNull
        : null;

    return ChampionshipEligibilityResult(
      isAlreadyRegistered: isAlreadyRegistered,
      isGenderAllowed: isGenderAllowed,
      canRegister: canRegister,
      genderBlockReason: _genderBlockReasonText(
        championship.genderCategory,
        input.userGender,
        isAlreadyRegistered,
      ),
      myTeamId: myTeamId,
    );
  }

  /// Synchronous version — safe because this use case has no I/O.
  /// Use from widget build() methods instead of execute().
  ChampionshipEligibilityResult executeSync(ChampionshipEligibilityInput input) {
    final userId = input.userId;
    final championship = input.championship;
    final teams = input.teams;
    final isAlreadyRegistered = userId != null && teams.any((t) => t.memberIds.contains(userId));
    final isGenderAllowed = _isGenderAllowed(championship.genderCategory, input.userGender);
    final canRegister = userId != null && !isAlreadyRegistered && isGenderAllowed &&
        championship.status == ChampionshipStatus.registration && championship.isOpen;
    final myTeamId = userId != null
        ? teams.where((t) => t.memberIds.contains(userId)).map((t) => t.id).firstOrNull
        : null;
    return ChampionshipEligibilityResult(
      isAlreadyRegistered: isAlreadyRegistered,
      isGenderAllowed: isGenderAllowed,
      canRegister: canRegister,
      genderBlockReason: _genderBlockReasonText(championship.genderCategory, input.userGender, isAlreadyRegistered),
      myTeamId: myTeamId,
    );
  }

  bool _isGenderAllowed(
    ChampionshipGenderCategory? category,
    String? userGender,
  ) {
    // Gender check temporarily disabled — admins manually remove
    // teams that don't match the league's gender category.
    return true;
  }

  String? _genderBlockReasonText(
    ChampionshipGenderCategory? category,
    String? userGender,
    bool alreadyRegistered,
  ) {
    // Gender block disabled — see _isGenderAllowed.
    return null;
  }
}
