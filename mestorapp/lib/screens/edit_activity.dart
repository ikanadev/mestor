import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mestorapp/domain/domain.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/providers/providers.dart';
import 'package:mestorapp/utils/utils.dart';
import 'package:mestorapp/widgets/widgets.dart';

class EditActivity extends ConsumerStatefulWidget {
  final String actId;
  const EditActivity({super.key, required this.actId});

  @override
  ConsumerState<EditActivity> createState() => _EditActivity();
}

class _EditActivity extends ConsumerState<EditActivity> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  ActColor _color = ActColor.grey;
  Emoji _emoji = const Emoji("", "");

  @override
  void initState() {
    super.initState();
    ref.read(activityProvider(widget.actId).future).then((act) {
      _nameCont.text = act.name;
      setState(() {
        _color = act.color;
        _emoji = Emoji(act.emoji, "");
      });
    });
  }

  void _handleEdit() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    final actData = EditActivityData(
      id: widget.actId,
      color: _color,
      name: _nameCont.text,
      emoji: _emoji.emoji,
    );
    ref.read(activitiesProvider.notifier).editActivity(actData);
    context.pop();
  }

  void _setColor(ActColor color) {
    setState(() => _color = color);
  }

  void _setEmoji(Emoji emoji) {
    setState(() => _emoji = emoji);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Activity"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: nonEmptyValidator,
                  maxLength: 20,
                  controller: _nameCont,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Color:"),
                  ColorPickerButton(color: _color, onSelect: _setColor),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Emoji:"),
                  EmojiPickerButton(emoji: _emoji, onEmojiPicked: _setEmoji),
                ],
              ),
              const SizedBox(height: 28),
              ElevatedButton(onPressed: _handleEdit, child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
