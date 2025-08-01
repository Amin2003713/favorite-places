import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/palce.dart';
import '../states/places_states.dart';
import 'image_input.dart';
import 'location_input.dart';

class AddPlace extends ConsumerWidget {
  AddPlace({super.key});

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  File? _image;

  void _reset() {
    _formKey.currentState?.reset();
  }

  void _save(WidgetRef ref, BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please pick an image.')));
      return;
    }

    _formKey.currentState!.save();

    ref
        .read(PlaceProvider.notifier)
        .addNewPlace(Place(name: _name, image: _image!));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Place'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Enter Place Details',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name.';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _name = newValue!.trim(),
                  ),
                  const SizedBox(height: 20),
                  FormField<File>(
                    validator: (_) =>
                        _image == null ? 'Please select an image.' : null,
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageInput(
                            onSave: (file) {
                              _image = file;
                              field.didChange(file);
                            },
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                field.errorText!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  LocationInput(),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.icon(
                        onPressed: () => _save(ref, context),
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
