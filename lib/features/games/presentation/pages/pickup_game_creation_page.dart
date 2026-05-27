// Page for creating a pickup game with optional player invitations.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/data/models/activity_context_type.dart';
import 'package:play_with_me/core/domain/repositories/invitation_repository.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/play_with_me_app_bar.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/authentication/authentication_bloc.dart';
import '../../../auth/presentation/bloc/authentication/authentication_state.dart';
import '../bloc/game_creation/game_creation_bloc.dart';
import '../bloc/game_creation/game_creation_event.dart';
import '../bloc/game_creation/game_creation_state.dart';
import '../bloc/invitee_selection/invitee_selection_bloc.dart';
import '../bloc/invitee_selection/invitee_selection_event.dart';
import '../bloc/invitee_selection/invitee_selection_state.dart';
import '../widgets/invitee_picker.dart';

class PickupGameCreationPage extends StatelessWidget {
  /// Groups the current user belongs to: groupId → groupName.
  final Map<String, String> userGroups;

  const PickupGameCreationPage({super.key, this.userGroups = const {}});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameCreationBloc>(
          create: (_) => sl<GameCreationBloc>()
            ..add(const SetContextType(contextType: ActivityContextType.pickup)),
        ),
        BlocProvider<InviteeSelectionBloc>(
          create: (ctx) {
            final authState = ctx.read<AuthenticationBloc>().state;
            final userId = authState is AuthenticationAuthenticated
                ? authState.user.uid
                : '';
            return sl<InviteeSelectionBloc>()
              ..add(LoadInvitees(userId: userId, groups: userGroups));
          },
        ),
      ],
      child: const _PickupGameCreationView(),
    );
  }
}

class _PickupGameCreationView extends StatefulWidget {
  const _PickupGameCreationView();

  @override
  State<_PickupGameCreationView> createState() =>
      _PickupGameCreationViewState();
}

class _PickupGameCreationViewState extends State<_PickupGameCreationView> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1 form state
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = now.add(const Duration(days: 1));
    const blue = AppColors.secondary;
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<GameCreationBloc>();

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      helpText: l10n.selectGameDate,
      builder: (context, child) => Theme(
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
      ),
    );

    if (date == null || !context.mounted) return;

    TimeOfDay? time;
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final minPickerTime = isToday ? now : null;
    DateTime pickerTime = isToday
        ? DateTime(date.year, date.month, date.day, now.hour, now.minute)
            .add(const Duration(hours: 1))
        : DateTime(date.year, date.month, date.day, 14, 0);

    // ignore: use_build_context_synchronously
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(l10n.cancel,
                          style: const TextStyle(color: blue, fontSize: 16)),
                    ),
                    Column(
                      children: [
                        Text(l10n.selectGameTime,
                            style: const TextStyle(
                                color: blue,
                                fontSize: 17,
                                fontWeight: FontWeight.w600)),
                        if (isToday)
                          Text(
                            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${l10n.orLater}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        time = TimeOfDay(
                            hour: pickerTime.hour,
                            minute: pickerTime.minute);
                        Navigator.pop(dialogContext);
                      },
                      child: Text(l10n.ok,
                          style: const TextStyle(
                              color: blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: pickerTime,
                  minimumDate: minPickerTime,
                  use24hFormat: true,
                  onDateTimeChanged: (dt) => pickerTime = dt,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );

    if (time == null || !mounted) return;

    final dateTime = DateTime(
        date.year, date.month, date.day, time!.hour, time!.minute);
    setState(() => _selectedDateTime = dateTime);
    bloc.add(SetDateTime(dateTime: dateTime));
  }

  void _onNextStep(BuildContext context) {
    if (!_formKey.currentState!.validate() || _selectedDateTime == null) {
      if (_selectedDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.tapToSelect),
            backgroundColor: AppColors.danger,
          ),
        );
      }
      return;
    }

    final bloc = context.read<GameCreationBloc>();
    bloc.add(SetTitle(title: _titleController.text.trim()));
    if (_descriptionController.text.trim().isNotEmpty) {
      bloc.add(
          SetDescription(description: _descriptionController.text.trim()));
    }
    bloc.add(SetLocation(
      locationName: _locationController.text.trim(),
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : null,
    ));
    bloc.add(SetDateTime(dateTime: _selectedDateTime!));
    _goToStep(1);
  }

  Future<void> _onSubmit(
    BuildContext context,
    String userId, {
    required bool skipInvitations,
  }) async {
    final gameBloc = context.read<GameCreationBloc>();
    final inviteeBloc = context.read<InviteeSelectionBloc>();

    gameBloc.add(SubmitGame(createdBy: userId));

    // Wait for game creation result.
    final resultState = await gameBloc.stream.firstWhere(
      (s) => s is GameCreationSuccess || s is GameCreationError,
    );

    if (!context.mounted) return;

    if (resultState is GameCreationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultState.message),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    if (resultState is GameCreationSuccess && !skipInvitations) {
      final inviteeState = inviteeBloc.state;
      if (inviteeState is InviteeSelectionLoaded &&
          inviteeState.selectedIds.isNotEmpty) {
        final invitationRepo = sl<InvitationRepository>();
        for (final uid in inviteeState.selectedIds) {
          try {
            await invitationRepo.sendGameInvitation(
              gameId: resultState.gameId,
              invitedUserId: uid,
            );
          } catch (_) {
            // Best-effort — continue sending remaining invitations.
          }
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.invitationsSentSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.pickupGameCreatedSuccess),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop(resultState is GameCreationSuccess
          ? resultState.game
          : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<GameCreationBloc, GameCreationState>(
      listener: (context, state) {
        if (state is GameCreationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      },
      builder: (context, creationState) {
        final isSubmitting = creationState is GameCreationSubmitting;

        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            if (authState is! AuthenticationAuthenticated) {
              return Scaffold(
                appBar: PlayWithMeAppBar.build(
                    context: context, title: l10n.pickupGame),
                body: Center(child: Text(l10n.pleaseLogInToCreateGame)),
              );
            }
            final userId = authState.user.uid;

            return Scaffold(
              appBar: PlayWithMeAppBar.build(
                context: context,
                title: _currentStep == 0
                    ? l10n.gameDetailsStep
                    : l10n.invitePlayersStep,
              ),
              body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _GameDetailsStep(
                    formKey: _formKey,
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    locationController: _locationController,
                    addressController: _addressController,
                    selectedDateTime: _selectedDateTime,
                    isSubmitting: isSubmitting,
                    onSelectDateTime: () => _selectDateTime(context),
                    onNext: () => _onNextStep(context),
                  ),
                  _InviteStep(
                    isSubmitting: isSubmitting,
                    onSkip: () => _onSubmit(context, userId,
                        skipInvitations: true),
                    onSubmit: () => _onSubmit(context, userId,
                        skipInvitations: false),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _GameDetailsStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final TextEditingController addressController;
  final DateTime? selectedDateTime;
  final bool isSubmitting;
  final VoidCallback onSelectDateTime;
  final VoidCallback onNext;

  const _GameDetailsStep({
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.locationController,
    required this.addressController,
    required this.selectedDateTime,
    required this.isSubmitting,
    required this.onSelectDateTime,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pickup Game badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.flash_on,
                      color: AppColors.secondary, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    l10n.pickupGame,
                    style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Title
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: l10n.gameTitle,
                hintText: l10n.gameTitleHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.sports_volleyball),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.pleaseTitleRequired;
                }
                if (value.trim().length < 3) return l10n.titleMinLength;
                if (value.trim().length > 100) return l10n.titleMaxLength;
                return null;
              },
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: l10n.descriptionOptional,
                hintText: l10n.gameDescriptionHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 16),

            // Date/Time picker
            Material(
              child: ListTile(
                title: Text(l10n.dateTime),
                subtitle: selectedDateTime != null
                    ? Text(
                        '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year}'
                        ' ${selectedDateTime!.hour.toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')}',
                      )
                    : Text(l10n.tapToSelect,
                        style: const TextStyle(color: AppColors.danger)),
                leading: const Icon(Icons.calendar_today),
                trailing:
                    const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: isSubmitting ? null : onSelectDateTime,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: selectedDateTime == null
                        ? AppColors.danger
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Location
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: l10n.location,
                hintText: l10n.locationHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.pleaseEnterLocation;
                }
                return null;
              },
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 16),

            // Address (optional)
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: l10n.addressOptional,
                hintText: l10n.addressHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.place),
              ),
              enabled: !isSubmitting,
            ),
            const SizedBox(height: 24),

            // Next button
            ElevatedButton(
              onPressed: isSubmitting ? null : onNext,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(l10n.next, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteStep extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSkip;
  final VoidCallback onSubmit;

  const _InviteStep({
    required this.isSubmitting,
    required this.onSkip,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Selected count badge
        BlocBuilder<InviteeSelectionBloc, InviteeSelectionState>(
          builder: (context, state) {
            if (state is! InviteeSelectionLoaded) return const SizedBox.shrink();
            final count = state.selectedIds.length;
            if (count == 0) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                l10n.selectedCount(count),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        // Tabbed picker fills the remaining space
        const Expanded(child: InviteePicker()),
        // Action buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isSubmitting ? null : onSkip,
                  child: Text(l10n.skipInvitations),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : onSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.createAndInvite),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
