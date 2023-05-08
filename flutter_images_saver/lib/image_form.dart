import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ImageForm extends StatefulWidget {
  final ValueSetter<Uri> onSubmit;

  const ImageForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  final _error = ValueNotifier('');
  final _urlImageFocusNode = FocusNode();
  late final TextEditingController _urlImageController;

  @override
  void initState() {
    super.initState();
    _urlImageController =
        TextEditingController(text: 'https://placehold.co/600x400.jpg?text=${const Uuid().v4().split('-').first}');

    _urlImageController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _urlImageController
      ..removeListener(_onChanged)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _urlImageFocusNode,
                controller: _urlImageController,
                onSubmitted: (_) => _onSubmitted(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  labelText: 'Type image url and GO!',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Type image and GO!',
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _onSubmitted,
              icon: const Icon(Icons.download),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _error,
          builder: (_, error, __) {
            return Text(error);
          },
        ),
      ],
    );
  }

  void _onChanged() {
    final value = _urlImageController.text;
    if (value.isEmpty) {
      _error.value = 'Не правильный url';
      return;
    }

    _error.value = '';
  }

  void _onSubmitted() {
    _urlImageFocusNode.unfocus();
    final url = Uri.tryParse(_urlImageController.text);
    if (url == null) {
      _error.value = 'Не правильный url';
    } else {
      _error.value = '';
      widget.onSubmit(url);
    }
  }
}
