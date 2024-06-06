
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

final mockPost1 = MockArchivingPost(
    postId: 1,
    userId: 123,
    note: "맛있는 위스키 최고!!",
    tasteFeatures: [
      TasteFeature(
          title: "test1",
          lowExpression: "low",
          highExpression: "high",
          value: 2)
    ],
    createAt: "20040506",
    barcode: "00000",
    whiskyName: "Arran1996",
    starValue: 5,
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/whilabel.appspot.com/o/post%2Farchiving_post%2Fgoogle%3A116895248812367520964%2B1702190878827404%2F12001260-1d84-1e77-bb44-2bda63f09dc5%5Egoogle%3A116895248812367520964%2B1702190878827404%7D.jpg?alt=media&token=a2b830ca-4a3c-4ff8-a1a2-ac6f777d02ae",
    whiskyId: "00",
    strength: "40",
    location: "켄벨 타운",
    modifyAt: "00000");






final mockPost2 = MockArchivingPost(
    postId: 2,
    userId: 123,
    note: "아이고 맛이었누 위스키 최고!!",
    tasteFeatures: [
      TasteFeature(
          title: "test1",
          lowExpression: "low1",
          highExpression: "high1",
          value: 2),
      TasteFeature(
          title: "test2",
          lowExpression: "low2",
          highExpression: "high2",
          value: 2)

    ],
    createAt: "20140506",
    barcode: "00000",
    whiskyName: "Glenfiddich18-year-old",
    starValue: 3,
    imageUrl: "https://firebasestorage.googleapis.com/v0/b/whilabel.appspot.com/o/post%2Ftest%2F228cf6c0-7abd-1ef4-9563-454b338ab4ed%5Egoogle%3A101526050135084726156%2B1709278603063225%7D.jpg?alt=media&token=1c977bb2-7c9c-4dd5-90cc-b0e52dce6a05",
    whiskyId: "00",
    strength: "40",
    location: "켄벨 타운",
    modifyAt: "00000");

