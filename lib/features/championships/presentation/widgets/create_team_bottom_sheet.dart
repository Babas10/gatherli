// Bottom sheet for creating a championship team: team name + single-select partner picker.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_event.dart';
import 'package:play_with_me/features/championships/presentation/widgets/partner_picker_list.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class CreateTeamBottomSheet extends StatefulWidget {
  final String championshipId;
  final String userId;

  const CreateTeamBottomSheet({
    super.key,
    required this.championshipId,
    required this.userId,
  });

  @override
  State<CreateTeamBottomSheet> createState() => _CreateTeamBottomSheetState();
}

class _CreateTeamBottomSheetState extends State<CreateTeamBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PartnerPickerBloc>().add(LoadPartners(widget.userId));
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final partnerState = context.read<PartnerPickerBloc>().state;
    if (partnerState is! PartnerPickerLoaded ||
        partnerState.selectedPartnerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.selectPartnerLabel,
          ),
        ),
      );
      return;
    }

    context.read<TeamRegistrationBloc>().add(CreateTeam(
          championshipId: widget.championshipId,
          teamName: _teamNameController.text.trim(),
          partnerId: partnerState.selectedPartnerId!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              children: [
                // Title
                Text(
                  l10n.createTeamTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.xl),

                // Team name field
                TextFormField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    labelText: l10n.teamNameLabel,
                    hintText: l10n.teamNameHint,
                    border: const OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.teamNameLabel;
                    }
                    if (value.trim().length < 2) return l10n.teamNameLabel;
                    if (value.trim().length > 50) return l10n.teamNameLabel;
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Partner picker
                Text(
                  l10n.selectPartnerLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                BlocBuilder<PartnerPickerBloc, PartnerPickerState>(
                  builder: (context, state) {
                    if (state is PartnerPickerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is PartnerPickerLoaded) {
                      return PartnerPickerList(
                        friends: state.friends,
                        selectedPartnerId: state.selectedPartnerId,
                        onPartnerSelected: (uid) {
                          context
                              .read<PartnerPickerBloc>()
                              .add(SelectPartner(uid));
                        },
                      );
                    }
                    if (state is PartnerPickerError) {
                      return Text(state.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Submit button
                BlocBuilder<PartnerPickerBloc, PartnerPickerState>(
                  builder: (context, partnerState) {
                    final hasPartner = partnerState is PartnerPickerLoaded &&
                        partnerState.selectedPartnerId != null;
                    return FilledButton(
                      onPressed: hasPartner ? _submit : null,
                      child: Text(l10n.registerTeam),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
