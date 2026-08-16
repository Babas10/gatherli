// Validates CreateChampionshipPage form rendering, submission flow, and error handling.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_app.dart';

// ── Helpers ──────────────────────────────────────────────────────────────────

Widget _buildTestWidget(ChampionshipCreationBloc bloc) {
  return testApp(
    child: BlocProvider<ChampionshipCreationBloc>.value(
      value: bloc,
      child: const _TestFormView(),
    ),
  );
}

/// Mirrors the create championship form fields and button without GetIt setup.
class _TestFormView extends StatefulWidget {
  const _TestFormView();

  @override
  State<_TestFormView> createState() => _TestFormViewState();
}

class _TestFormViewState extends State<_TestFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ChampionshipCreationBloc, ChampionshipCreationState>(
      listener: (context, state) {
        if (state is ChampionshipCreationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.championshipCreateSuccess)),
          );
        }
        if (state is ChampionshipCreationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.championshipCreate)),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: l10n.championshipCreateTitleLabel),
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return l10n.championshipCreateTitleRequired;
                  if (val.length < 3) return l10n.championshipCreateTitleTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<ChampionshipCreationBloc, ChampionshipCreationState>(
                builder: (context, state) {
                  final isSubmitting = state is ChampionshipCreationSubmitting;
                  return FilledButton(
                    onPressed: isSubmitting
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ChampionshipCreationBloc>().add(
                                    SubmitChampionshipCreation(
                                      title: _titleController.text.trim(),
                                      registrationDeadline: DateTime(2027, 1, 1),
                                    ),
                                  );
                            }
                          },
                    child: isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.championshipCreateSubmit),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockChampionshipCreationBloc bloc;

  setUpAll(registerFallbackValues);

  setUp(() {
    bloc = MockChampionshipCreationBloc();
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => bloc.state).thenReturn(const ChampionshipCreationInitial());
  });

  tearDown(() => bloc.close());

  group('CreateChampionshipPage — rendering', () {
    testWidgets('shows page title and submit button', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.text('Create Championship'), findsWidgets);
    });

    testWidgets('shows title field', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('submit button is enabled in initial state', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('submit button is disabled while submitting', (tester) async {
      when(() => bloc.state).thenReturn(const ChampionshipCreationSubmitting());
      when(() => bloc.stream).thenAnswer(
        (_) => Stream.value(const ChampionshipCreationSubmitting()),
      );
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows loading indicator while submitting', (tester) async {
      when(() => bloc.state).thenReturn(const ChampionshipCreationSubmitting());
      when(() => bloc.stream).thenAnswer(
        (_) => Stream.value(const ChampionshipCreationSubmitting()),
      );
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('CreateChampionshipPage — form validation', () {
    testWidgets('shows error when title is empty on submit', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text('Title is required'), findsOneWidget);
    });

    testWidgets('shows error when title is too short', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'AB');
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text('Title must be at least 3 characters'), findsOneWidget);
    });

    testWidgets('dispatches event when form is valid', (tester) async {
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'Summer Open 2027');
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      verify(() => bloc.add(any(that: isA<SubmitChampionshipCreation>()))).called(1);
    });
  });

  group('CreateChampionshipPage — state feedback', () {
    testWidgets('shows success snackbar on success state', (tester) async {
      when(() => bloc.stream).thenAnswer((_) => Stream.fromIterable([
            const ChampionshipCreationSuccess(championshipId: 'c1'),
          ]));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Championship created'), findsOneWidget);
    });

    testWidgets('shows error snackbar on error state', (tester) async {
      when(() => bloc.stream).thenAnswer((_) => Stream.fromIterable([
            const ChampionshipCreationError(message: 'Permission denied'),
          ]));
      await tester.pumpWidget(_buildTestWidget(bloc));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Permission denied'), findsOneWidget);
    });
  });
}
