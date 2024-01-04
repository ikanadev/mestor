import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiPickerButton extends StatelessWidget {
  const EmojiPickerButton({
    super.key,
    required this.onEmojiPicked,
    required this.emoji,
  });
  final ValueChanged<Emoji> onEmojiPicked;
  final Emoji emoji;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) =>
              _EmojiPicker(emoji: emoji, onEmojiPicked: onEmojiPicked),
        );
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        child: Text(
          emoji.emoji,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
        ),
      ),
    );
  }
}

class _EmojiPicker extends StatelessWidget {
  final Emoji emoji;
  final ValueChanged<Emoji> onEmojiPicked;

  const _EmojiPicker({required this.emoji, required this.onEmojiPicked});

  void _closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick an emoji'),
      insetPadding: const EdgeInsets.all(2),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 500,
            width: 900,
            child: EmojiPicker(
              onEmojiSelected: (cat, emoji) {
                onEmojiPicked(emoji);
                _closeDialog(context);
              },
              config: const Config(
                bgColor: Colors.transparent,
                enableSkinTones: false,
                recentTabBehavior: RecentTabBehavior.NONE,
              ),
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
