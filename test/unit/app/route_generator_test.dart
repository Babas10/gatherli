// Validates RouteGenerator generates correct routes for standard and deep link paths.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/app/route_generator.dart';
import 'package:play_with_me/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/password_reset/password_reset_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:play_with_me/features/friends/presentation/pages/my_community_page.dart';

void main() {
  group('RouteGenerator', () {
    group('standard routes', () {
      test('generates LoginPage for /login', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/login'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        // LoginPage is now wrapped in its own page-scoped BlocProvider
        // (Story 35.5) instead of relying on an app-root LoginBloc.
        expect(
          pageRoute.builder(MockBuildContext()),
          isA<BlocProvider<LoginBloc>>(),
        );
      });

      test('generates RegistrationPage for /register', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/register'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        expect(
          pageRoute.builder(MockBuildContext()),
          isA<BlocProvider<RegistrationBloc>>(),
        );
      });

      test('generates PasswordResetPage for /forgot-password', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/forgot-password'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        expect(
          pageRoute.builder(MockBuildContext()),
          isA<BlocProvider<PasswordResetBloc>>(),
        );
      });

      test('generates MyCommunityPage for /my-community', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/my-community'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        expect(pageRoute.builder(MockBuildContext()), isA<MyCommunityPage>());
      });
    });

    group('deep link routes', () {
      test('generates LoginPage for /invite/{token} deep link', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/invite/abc123def456'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        expect(
          pageRoute.builder(MockBuildContext()),
          isA<BlocProvider<LoginBloc>>(),
        );
      });

      test('generates LoginPage for invite deep link with complex token', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/invite/R3nD0m-T0k3n_base64url'),
        );

        expect(route, isA<MaterialPageRoute>());
        final pageRoute = route as MaterialPageRoute;
        expect(
          pageRoute.builder(MockBuildContext()),
          isA<BlocProvider<LoginBloc>>(),
        );
      });
    });

    group('unknown routes', () {
      test('generates unknown route page for unrecognized route', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: '/nonexistent'),
        );

        expect(route, isA<MaterialPageRoute>());
      });

      test('generates unknown route page for null route name', () {
        final route = RouteGenerator.generateRoute(
          const RouteSettings(name: null),
        );

        expect(route, isA<MaterialPageRoute>());
      });

      test('preserves route settings', () {
        const settings = RouteSettings(name: '/login', arguments: 'test-arg');
        final route = RouteGenerator.generateRoute(settings);

        expect(route.settings, settings);
      });
    });
  });
}

class MockBuildContext extends Fake implements BuildContext {}
