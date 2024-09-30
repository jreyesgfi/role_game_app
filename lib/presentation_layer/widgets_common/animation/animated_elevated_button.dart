import 'package:flutter/material.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';

class CustomAnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color enabledColor;
  final Color disabledColor;
  final Color enabledTextColor;
  final Color disabledTextColor;
  final Duration duration;
  final ShapeBorder? shape;

  const CustomAnimatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.enabledColor,
    required this.disabledColor,
    required this.enabledTextColor,
    required this.disabledTextColor,
    this.duration = const Duration(milliseconds: 300),
    this.shape,
  }) : super(key: key);

  @override
  _CustomAnimatedButtonState createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late Color currentColor;
  late Color currentTextColor;

  @override
  void initState() {
    super.initState();
    // Initialize colors based on the initial onPressed state
    currentColor = widget.onPressed != null ? widget.enabledColor : widget.disabledColor;
    currentTextColor = widget.onPressed != null ? widget.enabledTextColor : widget.disabledTextColor;
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newColor = widget.onPressed != null ? widget.enabledColor : widget.disabledColor;
    final newTextColor = widget.onPressed != null ? widget.enabledTextColor : widget.disabledTextColor;

    if (newColor != currentColor || newTextColor != currentTextColor) {
      setState(() {
        currentColor = newColor;
        currentTextColor = newTextColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      decoration: BoxDecoration(
        color: currentColor,
        borderRadius: widget.shape != null
            ? (widget.shape as RoundedRectangleBorder).borderRadius
            : BorderRadius.circular(8.0),
      ),
      child: Material(
        color: Colors.transparent,
        shape: widget.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: AppTheme.borderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: AnimatedDefaultTextStyle(
              duration: widget.duration,
              style: TextStyle(
                color: currentTextColor,
                fontWeight: FontWeight.bold,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
