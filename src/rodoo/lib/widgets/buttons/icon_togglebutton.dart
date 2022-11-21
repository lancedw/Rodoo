import 'package:flutter/material.dart';

class IconToggleButton extends StatefulWidget {
  const IconToggleButton(
      {required this.isEnabled,
      required this.activeIcon,
      required this.nonActiveIcon,
      required this.iconSize,
      required this.selected,
      super.key});

  final Icon activeIcon;
  final Icon nonActiveIcon;
  final bool isEnabled;
  final double iconSize;
  final bool selected;

  @override
  State<IconToggleButton> createState() => _IconToggleButtonState();
}

class _IconToggleButtonState extends State<IconToggleButton> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = widget.isEnabled
        ? () {
            setState(() {
              selected = !selected;
            });
          }
        : null;

    return IconButton(
      isSelected: selected,
      icon: widget.nonActiveIcon,
      selectedIcon: widget.activeIcon,
      iconSize: widget.iconSize,
      onPressed: onPressed,
    );
  }
}
