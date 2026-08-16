// Shared form section layout — section label + content with consistent spacing.
// Use in all creation/edit pages instead of manual Padding+Column+Text combos.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';

/// A labeled section inside a form. Renders an uppercase section label
/// (using [AppTextStyles.sectionLabel]) above the [child] content.
class FormSection extends StatelessWidget {
  final String? label;
  final Widget child;
  final double bottomSpacing;

  const FormSection({
    super.key,
    this.label,
    required this.child,
    this.bottomSpacing = AppSpacing.lg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!.toUpperCase(), style: AppTextStyles.sectionLabel),
          const SizedBox(height: AppSpacing.sm),
        ],
        child,
        SizedBox(height: bottomSpacing),
      ],
    );
  }
}

/// Two widgets placed side by side with a gap between them.
/// Useful for paired fields (e.g., gender options, date + time).
class FormRow extends StatelessWidget {
  final List<Widget> children;
  final double gap;

  const FormRow({
    super.key,
    required this.children,
    this.gap = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    final spaced = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spaced.add(Expanded(child: children[i]));
      if (i < children.length - 1) spaced.add(SizedBox(width: gap));
    }
    return Row(children: spaced);
  }
}
