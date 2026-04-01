import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, outline, ghost, link, destructive }

enum ButtonSize { sm, md, lg, icon }

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;

  const AppButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
  }) : assert(text != null || icon != null, 'Text or Icon must be provided');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Color Logic
    Color backgroundColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = theme.colorScheme.primary;
        textColor = theme.colorScheme.onPrimary;
        break;
      case ButtonVariant.secondary:
        backgroundColor = theme.colorScheme.secondary;
        textColor = theme.colorScheme.onSecondary;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        textColor = theme.colorScheme.primary;
        borderSide = BorderSide(color: theme.colorScheme.outline);
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        textColor = theme.colorScheme.primary;
        break;
      case ButtonVariant.link:
        backgroundColor = Colors.transparent;
        textColor = theme.colorScheme.primary;
        break;
      case ButtonVariant.destructive:
        backgroundColor = theme.colorScheme.error;
        textColor = theme.colorScheme.onError;
        break;
    }

    // Size Logic
    double height;
    EdgeInsets padding;
    double? minWidth;

    switch (size) {
      case ButtonSize.sm:
        height = 32;
        padding = const EdgeInsets.symmetric(horizontal: 12);
        break;
      case ButtonSize.md:
        height = 40;
        padding = const EdgeInsets.symmetric(horizontal: 16);
        break;
      case ButtonSize.lg:
        height = 48;
        padding = const EdgeInsets.symmetric(horizontal: 24);
        break;
      case ButtonSize.icon:
        height = 40;
        minWidth = 40;
        padding = EdgeInsets.zero;
        break;
    }

    final content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(textColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                if (text != null) const SizedBox(width: 8),
              ],
              if (text != null)
                Text(
                  text!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    decoration: variant == ButtonVariant.link ? TextDecoration.underline : null,
                  ),
                ),
            ],
          );

    return SizedBox(
      width: isFullWidth ? double.infinity : minWidth,
      height: height,
      child: Material(
        color: isDisabled ? backgroundColor.withOpacity(0.5) : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: borderSide,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: (isDisabled || isLoading) ? null : onPressed,
          child: Padding(
            padding: padding,
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
