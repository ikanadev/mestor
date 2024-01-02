import 'package:flutter/material.dart';
import 'package:mestorapp/utils/validators.dart';

class NewActivity extends StatefulWidget {
  const NewActivity({super.key});

  @override
  State<NewActivity> createState() => _NewActivity();
}

class _NewActivity extends State<NewActivity> {
  final _formKey = GlobalKey<FormState>();
  final _nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("New Activity")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "New Activity",
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: nonEmptyValidator,
                controller: _nameCont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
