import 'package:flutter/material.dart';
import 'package:mestorapp/domain/domain.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    super.key,
    required this.color,
    required this.onSelect,
  });
  final ActColor color;
  final ValueChanged<ActColor> onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => _ColorPicker(color: color, onSelect: onSelect),
        );
      },
      child: Container(
        width: 38,
        height: 25,
        decoration: BoxDecoration(
          color: getActColor(color: color),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final ActColor color;
  final ValueChanged<ActColor> onSelect;

  const _ColorPicker({required this.color, required this.onSelect});

  void _closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _pickColor(BuildContext context, ActColor color) {
    onSelect(color);
    _closeDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 180,
            width: 200,
            child: GridView.count(
              crossAxisCount: 4,
              // padding: const EdgeInsets.all(20),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: ActColor.values
                  .map((catCol) => InkWell(
                        onTap: () => _pickColor(context, catCol),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getActColor(color: catCol),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => _closeDialog(context),
        )
      ],
    );
  }
}
