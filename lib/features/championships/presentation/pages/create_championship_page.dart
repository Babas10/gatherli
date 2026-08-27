// Admin-only form to create a new championship.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/utils/date_picker_helper.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/presentation/widgets/global_bottom_nav_bar.dart';
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
  int _maxTeams = 10;

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showAppStyledDatePicker(
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
    final picked = await showAppStyledDatePicker(
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
    final picked = await showAppStyledDatePicker(
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
            maxTeams: _maxTeams,
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
              backgroundColor: AppColors.danger,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.championshipCreate)),
        bottomNavigationBar: GlobalBottomNavBar(
          selectedIndex: 4,
          onTabSelected: (index) {
            HomePage.onNavigateToTab?.call(index);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
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
              const SizedBox(height: AppSpacing.lg),

              // Gender category (required)
              Text(
                l10n.championshipCreateGenderLabel,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
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
                  const SizedBox(width: AppSpacing.md),
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
              const SizedBox(height: AppSpacing.lg),

              // Max teams
              const SizedBox(height: AppSpacing.xs),
              _SegmentedField<int>(
                label: l10n.championshipCreateMaxTeamsLabel,
                options: const [4, 6, 8, 10],
                selected: _maxTeams,
                labelFor: (v) => v.toString(),
                onChanged: (v) => setState(() => _maxTeams = v),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Registration deadline (required)
              _DatePicker(
                label: l10n.championshipCreateDeadlineLabel,
                date: _registrationDeadline,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickDeadline(context),
              ),
              const SizedBox(height: AppSpacing.md),

              // Start date (optional)
              _DatePicker(
                label: l10n.championshipCreateStartDateLabel,
                date: _startDate,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickStartDate(context),
              ),
              const SizedBox(height: AppSpacing.md),

              // End date (optional)
              _DatePicker(
                label: l10n.championshipCreateEndDateLabel,
                date: _endDate,
                placeholder: l10n.championshipCreateDatePlaceholder,
                onTap: () => _pickEndDate(context),
              ),
              const SizedBox(height: AppSpacing.lg),

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
              const SizedBox(height: AppSpacing.sm),

              // Region (optional)
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(
                  labelText: l10n.championshipCreateRegionLabel,
                  hintText: l10n.championshipCreateRegionHint,
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Submit
              BlocSelector<ChampionshipCreationBloc, ChampionshipCreationState,
                  bool>(
                selector: (state) => state is ChampionshipCreationSubmitting,
                builder: (context, isSubmitting) {
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
    const blue = AppColors.secondary;
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
            const SizedBox(height: AppSpacing.xs),
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

/// Generic segmented button row for selecting one value from a small option set.
class _SegmentedField<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T selected;
  final String Function(T) labelFor;
  final ValueChanged<T> onChanged;

  const _SegmentedField({
    required this.label,
    required this.options,
    required this.selected,
    required this.labelFor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const blue = AppColors.secondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: options.map((option) {
            final isSelected = option == selected;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: option == options.last ? 0 : 8,
                ),
                child: InkWell(
                  onTap: () => onChanged(option),
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      color: isSelected
                          ? blue.withValues(alpha: 0.06)
                          : Colors.transparent,
                    ),
                    child: Text(
                      labelFor(option),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isSelected ? blue : AppColors.textMuted,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
