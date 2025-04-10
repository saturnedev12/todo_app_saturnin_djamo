import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PriorityColor { none, warning, important }

class PriorityColorSelector extends StatefulWidget {
  final PriorityColor? initialValue;
  final ValueChanged<PriorityColor?> onChanged;

  const PriorityColorSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<PriorityColorSelector> createState() => _PriorityColorSelectorState();
}

class _PriorityColorSelectorState extends State<PriorityColorSelector> {
  final ValueNotifier<PriorityColor?> selected = ValueNotifier(null);
  bool showColors = false;

  @override
  void initState() {
    super.initState();
    selected.value = widget.initialValue ?? PriorityColor.none;
  }

  void _toggleSelector() {
    setState(() {
      showColors = !showColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PriorityColor?>(
      valueListenable: selected,
      builder: (context, value, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: showColors ? 150 : 80,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          decoration: BoxDecoration(
            color: showColors ? CupertinoColors.systemFill : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.palette, size: 18),
                onPressed: _toggleSelector,
                color: value == PriorityColor.none
                    ? Colors.grey
                    : (value == PriorityColor.warning
                        ? Colors.orange
                        : (value == PriorityColor.important
                            ? Colors.red
                            : Colors.grey)),
              ),
              if (showColors) ...[
                const SizedBox(width: 2),
                _colorDot(Colors.transparent, PriorityColor.none, "Normal"),
                _colorDot(Colors.orange, PriorityColor.warning, "Warning"),
                _colorDot(Colors.red, PriorityColor.important, "Important"),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _colorDot(Color color, PriorityColor type, String tooltip) {
    final isSelected = selected.value == type;
    return Flexible(
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () {
            selected.value = type;
            widget.onChanged(type);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(right: 8),
            width: isSelected ? 26 : 20,
            height: isSelected ? 26 : 20,
            decoration: BoxDecoration(
              color: color == Colors.transparent ? Colors.white : color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
                width: isSelected ? 2.5 : 1,
              ),
            ),
            child: color == Colors.transparent
                ? Center(
                    child: Icon(Icons.circle_outlined,
                        size: 14, color: Colors.grey))
                : null,
          ),
        ),
      ),
    );
  }
}
