// Validates AppLinksDeepLinkService correctly extracts invite tokens and
// shareable-activity-link targets from HTTPS (gatherli.org) and custom
// scheme (gatherli://) deep link URIs.
import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';
import 'package:play_with_me/core/services/app_links_deep_link_service.dart';

class MockAppLinks extends Mock implements AppLinks {}

void main() {
  late MockAppLinks mockAppLinks;
  late StreamController<Uri> linkStreamController;

  setUp(() {
    mockAppLinks = MockAppLinks();
    linkStreamController = StreamController<Uri>.broadcast();
    when(
      () => mockAppLinks.uriLinkStream,
    ).thenAnswer((_) => linkStreamController.stream);
  });

  tearDown(() {
    linkStreamController.close();
  });

  AppLinksDeepLinkService buildService() {
    return AppLinksDeepLinkService(appLinks: mockAppLinks);
  }

  group('AppLinksDeepLinkService', () {
    group('getInitialInviteToken — HTTPS deep links (gatherli.org)', () {
      test('extracts token from https://gatherli.org/invite/{token}', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/invite/abc123'),
        );
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, 'abc123');
        service.dispose();
      });

      test('returns null when HTTPS path has no invite segment', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/other/abc123'),
        );
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });

      test('returns null when HTTPS invite token is empty', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('https://gatherli.org/invite/'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });

      test('returns null when HTTPS path has too many segments', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/invite/abc123/extra'),
        );
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });
    });

    group('getInitialInviteToken — custom scheme (gatherli://)', () {
      test('extracts token from gatherli://invite/{token}', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('gatherli://invite/xyz789'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, 'xyz789');
        service.dispose();
      });

      test('returns null when custom scheme host is not invite', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('gatherli://other/xyz789'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });

      test('returns null for unknown scheme', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('unknown://invite/abc123'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });

      test('returns null when custom scheme token is empty', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('gatherli://invite/'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });
    });

    group('getInitialInviteToken — null / error handling', () {
      test('returns null when no initial link', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });

      test('returns null when getInitialLink throws', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenThrow(Exception('platform error'));
        final service = buildService();
        final token = await service.getInitialInviteToken();
        expect(token, isNull);
        service.dispose();
      });
    });

    group('inviteTokenStream — foreground deep links', () {
      test('emits token when HTTPS deep link received on stream', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
        final service = buildService();

        expectLater(service.inviteTokenStream, emits('stream-token-https'));

        linkStreamController.add(
          Uri.parse('https://gatherli.org/invite/stream-token-https'),
        );

        await Future.delayed(const Duration(milliseconds: 50));
        service.dispose();
      });

      test(
        'emits token when custom scheme deep link received on stream',
        () async {
          when(
            () => mockAppLinks.getInitialLink(),
          ).thenAnswer((_) async => null);
          final service = buildService();

          expectLater(service.inviteTokenStream, emits('stream-token-custom'));

          linkStreamController.add(
            Uri.parse('gatherli://invite/stream-token-custom'),
          );

          await Future.delayed(const Duration(milliseconds: 50));
          service.dispose();
        },
      );

      test('does not emit for unrecognised URIs', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
        final service = buildService();

        final emitted = <String?>[];
        final sub = service.inviteTokenStream.listen(emitted.add);

        linkStreamController.add(Uri.parse('https://example.com/other/path'));

        await Future.delayed(const Duration(milliseconds: 50));
        expect(emitted, isEmpty);
        await sub.cancel();
        service.dispose();
      });
    });

    group('getInitialActivityLink — HTTPS deep links (gatherli.org)', () {
      test('extracts GameLinkTarget from https://gatherli.org/game/{id}', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/game/game-1'),
        );
        final service = buildService();
        final target = await service.getInitialActivityLink();
        expect(target, const GameLinkTarget('game-1'));
        service.dispose();
      });

      test(
        'extracts TrainingSessionLinkTarget from https://gatherli.org/training/{id}',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async => Uri.parse('https://gatherli.org/training/session-1'),
          );
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(target, const TrainingSessionLinkTarget('session-1'));
          service.dispose();
        },
      );

      test(
        'extracts ChampionshipLinkTarget from https://gatherli.org/championship/{id}',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async => Uri.parse('https://gatherli.org/championship/champ-1'),
          );
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(target, const ChampionshipLinkTarget('champ-1'));
          service.dispose();
        },
      );

      test(
        'extracts ChampionshipMatchLinkTarget from '
        'https://gatherli.org/championship/{id}/match/{id}',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async => Uri.parse(
              'https://gatherli.org/championship/champ-1/match/match-1',
            ),
          );
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(
            target,
            const ChampionshipMatchLinkTarget(
              championshipId: 'champ-1',
              matchId: 'match-1',
            ),
          );
          service.dispose();
        },
      );

      test('returns null for an unrecognised HTTPS path', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/other/abc123'),
        );
        final service = buildService();
        final target = await service.getInitialActivityLink();
        expect(target, isNull);
        service.dispose();
      });

      test('returns null when the championship path is missing "match"', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async =>
              Uri.parse('https://gatherli.org/championship/champ-1/foo/match-1'),
        );
        final service = buildService();
        final target = await service.getInitialActivityLink();
        expect(target, isNull);
        service.dispose();
      });
    });

    group('getInitialActivityLink — custom scheme (gatherli://)', () {
      test('extracts GameLinkTarget from gatherli://game/{id}', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('gatherli://game/game-2'));
        final service = buildService();
        final target = await service.getInitialActivityLink();
        expect(target, const GameLinkTarget('game-2'));
        service.dispose();
      });

      test(
        'extracts TrainingSessionLinkTarget from gatherli://training/{id}',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async => Uri.parse('gatherli://training/session-2'),
          );
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(target, const TrainingSessionLinkTarget('session-2'));
          service.dispose();
        },
      );

      test(
        'extracts ChampionshipLinkTarget from gatherli://championship/{id}',
        () async {
          when(
            () => mockAppLinks.getInitialLink(),
          ).thenAnswer((_) async => Uri.parse('gatherli://championship/champ-2'));
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(target, const ChampionshipLinkTarget('champ-2'));
          service.dispose();
        },
      );

      test(
        'extracts ChampionshipMatchLinkTarget from '
        'gatherli://championship/{id}/match/{id}',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async =>
                Uri.parse('gatherli://championship/champ-2/match/match-2'),
          );
          final service = buildService();
          final target = await service.getInitialActivityLink();
          expect(
            target,
            const ChampionshipMatchLinkTarget(
              championshipId: 'champ-2',
              matchId: 'match-2',
            ),
          );
          service.dispose();
        },
      );

      test('returns null for unknown custom scheme host', () async {
        when(
          () => mockAppLinks.getInitialLink(),
        ).thenAnswer((_) async => Uri.parse('gatherli://other/abc123'));
        final service = buildService();
        final target = await service.getInitialActivityLink();
        expect(target, isNull);
        service.dispose();
      });
    });

    group('activityLinkStream — foreground deep links', () {
      test('emits GameLinkTarget when HTTPS game link received', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
        final service = buildService();

        expectLater(
          service.activityLinkStream,
          emits(const GameLinkTarget('stream-game')),
        );

        linkStreamController.add(
          Uri.parse('https://gatherli.org/game/stream-game'),
        );

        await Future.delayed(const Duration(milliseconds: 50));
        service.dispose();
      });

      test(
        'emits ChampionshipLinkTarget when HTTPS championship link received',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
          final service = buildService();

          expectLater(
            service.activityLinkStream,
            emits(const ChampionshipLinkTarget('stream-champ')),
          );

          linkStreamController.add(
            Uri.parse('https://gatherli.org/championship/stream-champ'),
          );

          await Future.delayed(const Duration(milliseconds: 50));
          service.dispose();
        },
      );

      test(
        'emits ChampionshipMatchLinkTarget when custom scheme match link received',
        () async {
          when(
            () => mockAppLinks.getInitialLink(),
          ).thenAnswer((_) async => null);
          final service = buildService();

          expectLater(
            service.activityLinkStream,
            emits(
              const ChampionshipMatchLinkTarget(
                championshipId: 'c1',
                matchId: 'm1',
              ),
            ),
          );

          linkStreamController.add(
            Uri.parse('gatherli://championship/c1/match/m1'),
          );

          await Future.delayed(const Duration(milliseconds: 50));
          service.dispose();
        },
      );

      test('does not emit on activityLinkStream for an invite link', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer((_) async => null);
        final service = buildService();

        final emitted = <ActivityLinkTarget?>[];
        final sub = service.activityLinkStream.listen(emitted.add);

        linkStreamController.add(Uri.parse('https://gatherli.org/invite/tok'));

        await Future.delayed(const Duration(milliseconds: 50));
        expect(emitted, isEmpty);
        await sub.cancel();
        service.dispose();
      });
    });

    group('getInitialLink memoization', () {
      test(
        'calling both getInitialInviteToken() and getInitialActivityLink() '
        'only invokes the native getInitialLink() once',
        () async {
          when(() => mockAppLinks.getInitialLink()).thenAnswer(
            (_) async => Uri.parse('https://gatherli.org/game/g1'),
          );
          final service = buildService();

          final token = await service.getInitialInviteToken();
          final target = await service.getInitialActivityLink();

          expect(token, isNull);
          expect(target, const GameLinkTarget('g1'));
          verify(() => mockAppLinks.getInitialLink()).called(1);
          service.dispose();
        },
      );

      test('order of calls does not matter for memoization', () async {
        when(() => mockAppLinks.getInitialLink()).thenAnswer(
          (_) async => Uri.parse('https://gatherli.org/invite/tok'),
        );
        final service = buildService();

        final target = await service.getInitialActivityLink();
        final token = await service.getInitialInviteToken();

        expect(target, isNull);
        expect(token, 'tok');
        verify(() => mockAppLinks.getInitialLink()).called(1);
        service.dispose();
      });
    });
  });
}
