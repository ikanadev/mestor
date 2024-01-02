import 'package:flutter/material.dart';
import 'package:mestorapp/domain/models/models.dart';
import 'package:mestorapp/utils/utils.dart';
import 'package:mestorapp/widgets/widgests.dart';

class NewActivity extends StatefulWidget {
  const NewActivity({super.key});

  @override
  State<NewActivity> createState() => _NewActivity();
}

class _NewActivity extends State<NewActivity> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();
  ActColor _color = ActColor.red;

  void _handleSave() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
  }

  void _setColor(ActColor color) {
    setState(() {
      _color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Activity"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Color:"),
                ColorPickerButton(color: _color, onSelect: _setColor),
              ],
            ),
            TextButton(onPressed: _handleSave, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
