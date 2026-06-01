// Admin-only form to create a new championship.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import '../bloc/championship_creation/championship_creation_bloc.dart';
import '../bloc/championship_creation/championship_creation_event.dart';
import '../bloc/championship_creation/championship_creation_state.dart';

class CreateChampionshipPage extends StatelessWidget {
  const CreateChampionshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChampionshipCreationBloc>(),
      child: const _CreateChampionshipView(),
    );
  }
}

class _CreateChampionshipView extends StatefulWidget {
  const _CreateChampionshipView();

  @override
  State<_CreateChampionshipView> createState() =>
      _CreateChampionshipViewState();
}

class _CreateChampionshipViewState extends State<_CreateChampionshipView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  DateTime? _registrationDeadline;
  DateTime? _startDate;
  DateTime? _endDate;
  ChampionshipGenderCategory? _genderCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  /// Shows a date picker with the same styling as the game creation form.
  Future<DateTime?> _showStyledDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    const blue = Color(0xFF004E64);
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              headerBackgroundColor: Colors.white,
              headerForegroundColor: blue,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return blue;
                return null;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return Colors.white;
                return null;
              }),
              dayShape: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: blue, width: 2),
                  );
                }
                return null;
              }),
              todayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return blue;
                return null;
              }),
              todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return Colors.white;
                return null;
              }),
              todayBorder: const BorderSide(color: Colors.transparent),
              yearForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return blue;
                return null;
              }),
              yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return Colors.white;
                return null;
              }),
              yearShape: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: blue, width: 2),
                  );
                }
                return null;
              }),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: blue),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<void> _pickDeadline(BuildContext context) async {
    final now = DateTime.now();
    final picked = await _showStyledDatePicker(
      context: context,
      initialDate: _registrationDeadline ?? now.add(const Duration(days: 30)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) setState(() => _registrationDeadline = picked);
  }

  Future<void> _pickStartDate(BuildContext context) async {
    final now = DateTime.now();
    final earliest = _registrationDeadline != null
        ? _registrationDeadline!.add(const Duration(days: 1))
        : now.add(const Duration(days: 1));
    final picked = await _showStyledDatePicker(
      context: context,
      initialDate: _startDate ?? earliest,
      firstDate: earliest,
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate(BuildContext context) async {
    final now = DateTime.now();
    final earliest = _startDate != null
        ? _startDate!.add(const Duration(days: 1))
        : now.add(const Duration(days: 2));
    final picked = await _showStyledDatePicker(
      context: context,
      initialDate: _endDate ?? earliest,
      firstDate: earliest,
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (_registrationDeadline == null) return;

    final country = _countryController.text.trim().toUpperCase();
    final region = _regionController.text.trim();

    context.read<ChampionshipCreationBloc>().add(
          SubmitChampionshipCreation(
            title: _titleController.text.trim(),
            registrationDeadline: _registrationDeadline!,
            startDate: _startDate,
            endDate: _endDate,
            country: country.isNotEmpty ? country : null,
            region: region.isNotEmpty ? region : null,
            genderCategory: _genderCategory,
          ),
        );
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
          Navigator.of(context).pop();
        }
        if (state is ChampionshipCreationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
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
              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.championshipCreateTitleLabel,
                  hintText: l10n.championshipCreateTitleHint,
                ),
                textCapitalization: TextCapitalization.words,
                maxLength: 100,
                validator: (v) {
                  final val = v?.trim() ?? '';
                  if (val.isEmpty) return l10n.championshipCreateTitleRequired;
                  if (val.length < 3) return l10n.championshipCreateTitleTooShort;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender category (required)
              Text(
                l10n.championshipCreateGenderLabel,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _GenderOption(
                      label: l10n.championshipGenderMale,
                      icon: Icons.male,
                      selected:
                          _genderCategory == ChampionshipGenderCategory.male,
                      onTap: () => setState(
                        () => _genderCategory = ChampionshipGenderCategory.male,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GenderOption(
                      label: l10n.championshipGenderFemale,
                      icon: Icons.female,
                      selected:
                          _genderCategory == ChampionshipGenderCategory.female,
                      onTap: () => setState(
                        () =>
                            _genderCategory = ChampionshipGenderCategory.female,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Registration deadline (required)
              _DatePicker(
                label: l10n.championshipCreateDeadlineLabel,
                date: _registrationDeadline,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickDeadline(context),
              ),
              const SizedBox(height: 12),

              // Start date (optional)
              _DatePicker(
                label: l10n.championshipCreateStartDateLabel,
                date: _startDate,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickStartDate(context),
              ),
              const SizedBox(height: 12),

              // End date (optional)
              _DatePicker(
                label: l10n.championshipCreateEndDateLabel,
                date: _endDate,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickEndDate(context),
              ),
              const SizedBox(height: 16),

              // Country (optional)
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: l10n.championshipCreateCountryLabel,
                  hintText: l10n.championshipCreateCountryHint,
                ),
                maxLength: 2,
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 8),

              // Region (optional)
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(
                  labelText: l10n.championshipCreateRegionLabel,
                  hintText: l10n.championshipCreateRegionHint,
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 32),

              // Submit
              BlocBuilder<ChampionshipCreationBloc, ChampionshipCreationState>(
                builder: (context, state) {
                  final isSubmitting = state is ChampionshipCreationSubmitting;
                  return FilledButton(
                    onPressed: isSubmitting ? null : () => _submit(context),
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

class _GenderOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF004E64);
    final color = selected ? blue : Colors.grey.shade400;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? blue : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? blue.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final String label;
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;

  const _DatePicker({
    required this.label,
    required this.date,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = date != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(
          hasValue ? DateFormat.yMMMd().format(date!) : placeholder,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: hasValue ? theme.textTheme.bodyMedium?.color : theme.hintColor,
          ),
        ),
      ),
    );
  }
}
