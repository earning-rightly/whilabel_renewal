

import 'package:photo_gallery/photo_gallery.dart';

class GallerySingleton {
  static final GallerySingleton instance = GallerySingleton._internal();
  factory GallerySingleton() => instance;
  GallerySingleton._internal();

  List<Album>? _albums;
  MediaPage? _mediaPage;

  Future<List<Album>> getAlbums() async {
    _albums ??= await PhotoGallery.listAlbums();
    return _albums!;
  }

  Future<MediaPage> getMediaPage() async {
    if (_mediaPage != null) {
      return _mediaPage!;
    }
    else {
      List<Album> albums = await getAlbums();
      _mediaPage = await albums.first.listMedia();
      return _mediaPage!;
    }
  }

}