import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

enum ImageDataType {
  file,
  url;
}

class ImageData {
  final String id;
  final ImageDataType type;

  final dynamic src;

  Uri get url => src as Uri;
  File get file => src as File;

  const ImageData._(this.id, this.type, this.src);

  factory ImageData.createUrl(Uri url) {
    return ImageData._(const Uuid().v4(), ImageDataType.url, url);
  }

  factory ImageData.createFile(String filePath) {
    return ImageData._(const Uuid().v4(), ImageDataType.file, File(filePath));
  }
}

class ImageDownloader extends StatefulWidget {
  final ImageData imageData;
  const ImageDownloader({Key? key, required this.imageData}) : super(key: key);

  @override
  State<ImageDownloader> createState() => _ImageDownloaderState();
}

class _ImageDownloaderState extends State<ImageDownloader> {
  bool _dataLoaded = false;
  late ImageData _imageData;

  @override
  initState() {
    if (widget.imageData.type == ImageDataType.file) {
      _dataLoaded = true;
      _imageData = widget.imageData;
    } else {
      _dataLoaded = false;
      _download(widget.imageData.url);
    }

    super.initState();
  }

  _download(Uri url) async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var dir = '${documentDirectory.path}/images';
    var filePath = '$dir/${const Uuid().v4()}';
    final imageData = ImageData.createFile(filePath);

    final dio = Dio();
    final response = await dio.get<List<int>>(url.toString(), options: Options(responseType: ResponseType.bytes));
    await imageData.file.writeAsBytes(response.data ?? []);

    // var response = await get(url);
    // imageData.file.writeAsBytesSync(response.bodyBytes);

    setState(() {
      _imageData = imageData;
      _dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dataLoaded) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(_imageData.src),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.cyan,
          strokeWidth: 5,
        ),
      );
    }
  }
}
