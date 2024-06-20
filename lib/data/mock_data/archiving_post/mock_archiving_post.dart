import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

part 'mock_archiving_post.g.dart';
part 'mock_archiving_post.freezed.dart';


@freezed
class MockArchivingPost with _$MockArchivingPost{
 factory MockArchivingPost({
   required int postId,
   required int userId,
   required String createAt,
    required  String whiskyId,
    required String barcode, // DB에서 검샥 안되는 위스키를 위해
    required String whiskyName,
    String? location, //생산지
    String? strength,
    String? modifyAt,
   String? distillery,
    required String imageUrl,
    required double starValue,
    required String note,
    required List<TasteFeature> tasteFeatures,
  }) = _MockArchivingPost;


 factory MockArchivingPost.fromJson(Map<String, dynamic> json) =>
     _$MockArchivingPostFromJson(json);




}
