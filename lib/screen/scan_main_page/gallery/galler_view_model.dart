


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:whilabel_renewal/screen/scan_main_page/gallery/gallery_state.dart';

import '../_pages/image_preview_page.dart';

class GalleryViewModel extends StateNotifier<GalleryState> {
  GalleryViewModel() : super(GalleryState.initial());

  List<Album>? _albums;
  bool _loading = false;
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
      List<Album> albums = await PhotoGallery.listAlbums();
      MediaPage mediaPage = await albums.first.listMedia();
      List<Medium> images = mediaPage.items
          .where((item) => item.mediumType == MediumType.image)
          .toList();

      _mediums.addAll(images);

      Set<String?>? albumNames = _albums
          ?.map((album) => album.name)
          .where((name) => name != null && name.isNotEmpty)
          .toSet();

      _albumNames = albumNames?.map((name) => name!).toList() ?? [];

      state = state.copyWith(albums: albums, mediums: this._mediums, albumNames: _albumNames,isLoading: false );
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
}