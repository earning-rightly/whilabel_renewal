import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/scan_main_page/_pages/image_preview_page.dart';

// ignore: must_be_immutable
class GalleryView extends StatefulWidget {
  GalleryView({super.key, this.isFindingBarcode = false});

  bool isFindingBarcode;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<Album>? _albums;
  bool _loading = false;
  List<String> _albumNames = [];
  List<Medium> mediums = [];

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums = await PhotoGallery.listAlbums();
      MediaPage mediaPage = await albums.first.listMedia();
      List<Medium> images = mediaPage.items
          .where((item) => item.mediumType == MediumType.image)
          .toList();

      setState(() {
        _albums = albums;
        // mediums.add(mediaPage.items[0]); // 카메라 버튼을 만들기 위한 쓰레기 데이터
        mediums.addAll(images);
        // _loading = false;
      });
      Set<String?>? albumNames = _albums
          ?.map((album) => album.name)
          .where((name) => name != null && name.isNotEmpty)
          .toSet();
      setState(() {
        _albumNames = albumNames?.map((name) => name!).toList() ?? [];
      });
    }

    setState(() {
      _loading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    // 로딩 처리 코드
    if (_loading) {
      return SafeArea(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor:
          widget.isFindingBarcode == true ? ColorsManager.black400 : null,
      body: SafeArea(
        child: _loading
            ? Stack(
                children: [
                  Positioned(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: mediums.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                  mainAxisSpacing: 4, //수평 Padding
                  crossAxisSpacing: 4, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  Medium medium = mediums[index];

                  // final viewModel = context.watch<CameraViewModel>();

                  return GestureDetector(
                    onTap: () async {
                      final initalFileImage = await medium.getFile();
                      // await viewModel.onEvent(CameraEvent.addMediums(mediums),

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImagePreviewPage(
                                  currentFile: initalFileImage,
                                )),
                      );
                    },
                    child: SizedBox(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: ThumbnailProvider(
                          mediumId: medium.id,
                          mediumType: medium.mediumType,
                          highQuality: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void changeAlbum(String albumTitle) async {
    List<Album> albums = await PhotoGallery.listAlbums();

    MediaPage mediaPage =
        await albums.firstWhere((item) => item.name == albumTitle).listMedia();
    setState(() {
      _albums = albums;
      mediums = mediaPage.items;
    });
    print("change tite====> $albumTitle");
  }
}
