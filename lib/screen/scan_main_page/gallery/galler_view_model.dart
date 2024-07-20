


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:whilabel_renewal/screen/scan_main_page/gallery/gallery_state.dart';
import 'package:whilabel_renewal/singleton/gallery_singleton.dart';

import '../_pages/image_preview_page.dart';
import 'dart:io' as Io;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:heic_to_jpg/heic_to_jpg.dart';

class GalleryViewModel extends StateNotifier<GalleryState> {
  GalleryViewModel() : super(GalleryState.initial());

  List<Album>? _albums;
  List<String> _albumNames = [];
  List<Medium> _mediums = [];
  BuildContext? _context;

  final provider = StateNotifierProvider<GalleryViewModel,GalleryState>( (_) {
    return GalleryViewModel();
  });


  void setBuildContext(BuildContext context) {
    _context = context;
  }



  Future<void> initProcess() async {
    if (await _promptPermissionSetting()) {
      _albums = await GallerySingleton.instance.getAlbums();
      final mediaPage = await GallerySingleton.instance.getMediaPage();
      List<Medium> images = mediaPage.items
          .where((item) => item.mediumType == MediumType.image)
          .toList();

      _mediums.addAll(images);

      Set<String?>? albumNames = _albums
          ?.map((album) => album.name)
          .where((name) => name != null && name.isNotEmpty)
          .toSet();

      _albumNames = albumNames?.map((name) => name!).toList() ?? [];

      state = state.copyWith(albums: _albums, mediums: _mediums, albumNames: _albumNames,isLoading: false );
    }
  }


  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted) {
        return true;
      }
    }
    return false;
  }



  void showImagePreviewPage(Medium medium) async {
    final initalFileImage = await medium.getFile();
    Navigator.push(
      _context!,
      MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
            currentFile: initalFileImage,
          )),
    );
  }



  Future<String> resizeImageAndGetModifiedPath(String filePath) async {

    final pngPath = await _convertHeicToPng(filePath);
    if (pngPath == null) {
      return "";
    }

    final bytes =  await Io.File(pngPath).readAsBytes();
    debugPrint("bytes ${bytes.length}");

    img.Image? image = img.decodeImage(bytes);

    if (image != null) {
      img.Image thumbnail = img.copyResize(image,width : 1024);

      final directory = await getTemporaryDirectory();
      final String tempPath = path.join(directory.path, "temp.png");

      final encoded = img.encodePng(thumbnail);

      await Io.File(tempPath).writeAsBytes(encoded);

      return tempPath;
    }
    else {
      debugPrint("image is null");
    }
    return "";
  }

  Future<String?> _convertHeicToPng(String filePath) async {
    if (filePath.toLowerCase().endsWith('.heic')) {
      try {
        // Convert HEIC to JPG first
        String? jpgPath = await HeicToJpg.convert(filePath);

        if (jpgPath != null) {
          // Convert JPG to PNG
          File jpgFile = File(jpgPath);
          List<int> imageBytes = await jpgFile.readAsBytes();
          String pngFilePath = path.withoutExtension(jpgPath) + '.png';
          File pngFile = File(pngFilePath);
          await pngFile.writeAsBytes(imageBytes);
          return pngFilePath;
        }
      } catch (e) {
        print('Error converting HEIC to PNG: $e');
        return null;
      }
    }
    return filePath;
  }



}