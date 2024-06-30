
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';

class CreateArchivingPostFooter extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  final MockArchivingPost currentPostData;

  CreateArchivingPostFooter({
    Key? key,
    required this.currentPostData,
  }) : super(key: key);

  bool isfilled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
          color: ColorsManager.black100,
          border:
              Border(top: BorderSide(width: 1, color: ColorsManager.black200))),
      height: 75,
      width: 340,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          // TODO 내가 찍은 사진 변형 UI로 보야주기
          //   flex: 40,
          //   child: Image.file(fit: BoxFit.cover, currentPostData.imageUrl!),
          // ),
          SizedBox(width: 12),
          Expanded(
            flex: 149,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    currentPostData.whiskyName,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                currentPostData.location != null
                    ? SizedBox(
                        child: Text(
                          "${currentPostData.location}\t${currentPostData.strength}%",
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    : SizedBox(
                        child: Text(
                          "\t${currentPostData.strength}%",
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 96,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.brown100,
              ),
              onPressed: () {},
              //TODO 다이어로그 viewModel에 입략
              child: const Text("등록하기"),
            ),
          )
        ],
      ),
    );
  }
}
