import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IconToggleButton extends StatefulWidget {
  const IconToggleButton(
      {required this.isEnabled,
      required this.activeIcon,
      required this.nonActiveIcon,
      required this.iconSize,
      required this.selected,
      required this.documentId,
      super.key});

  final Icon activeIcon;
  final Icon nonActiveIcon;
  final bool isEnabled;
  final double iconSize;
  final bool selected;
  final String? documentId;

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

  void updateFavorite(bool selected) async {
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.documentId)
        .update({'is_favorite': selected});
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = widget.isEnabled
        ? () {
            setState(() {
              selected = !selected;
              updateFavorite(selected);
            });
          }
        : null;

    return IconButton(
      isSelected: selected,
      icon: selected ? widget.activeIcon : widget.nonActiveIcon,
      // selectedIcon: const Icon(Icons.favorite),
      iconSize: widget.iconSize,
      onPressed: onPressed,
    );
  }
}
