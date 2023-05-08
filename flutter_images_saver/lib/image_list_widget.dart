import 'package:flutter/material.dart';
import 'package:flutter_images_saver/Image_downloader.dart';
import 'package:flutter_images_saver/image_form.dart';

class ImageListWidget extends StatefulWidget {
  const ImageListWidget({Key? key}) : super(key: key);

  @override
  State<ImageListWidget> createState() => _ImageListState();
}

class _ImageListState extends State<ImageListWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _visibleBottomSheet = ValueNotifier(false);
  final _images = ValueNotifier<List<ImageData>>([]);
  late PersistentBottomSheetController<void>? _bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Изображения'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _images,
        builder: (_, images, __) {
          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageDownloader(
                  key: ValueKey(images[index].id),
                  imageData: images[index],
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _visibleBottomSheet,
        builder: (BuildContext context, bool visible, Widget? child) {
          return FloatingActionButton(
            onPressed: visible ? _closeBottomSheet : _openBottomSheet,
            child: visible ? const Icon(Icons.close) : const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Future<void> _openBottomSheet() async {
    _visibleBottomSheet.value = true;
    _bottomSheetController = _scaffoldKey.currentState?.showBottomSheet<void>(
      (context) => SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ImageForm(
            onSubmit: (url) {
              final images = [..._images.value, ImageData.createUrl(url)];
              _images.value = images;
              _closeBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _closeBottomSheet() async {
    _visibleBottomSheet.value = false;
    _bottomSheetController?.close();
    _bottomSheetController = null;
  }
}
