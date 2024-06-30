
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';




class CreateArchivingPostFooter extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables

  final String whiskyName;
  final double strength;
  final String distilleryCountry;
  final String distilleryAddress;
  final File currentFile;
  final Function()? onPressedEvent;

  CreateArchivingPostFooter({
    Key? key,
    required this.whiskyName, required this.currentFile, required this.strength, required this.distilleryCountry, required this.distilleryAddress, this.onPressedEvent,
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
      height: 85,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 50,
            child: Image.file(currentFile,fit: BoxFit.cover, ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 149,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    whiskyName,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                distilleryAddress!= null
                    ? SizedBox(
                        child: Text(
                          "${distilleryAddress}\t${strength}%",
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    : SizedBox(
                        child: Text(
                          "\t${strength}%",
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
              onPressed: onPressedEvent ?? (){},
              //TODO 다이어로그 viewModel에 입략
              child: const Text("등록하기"),
            ),
          )
        ],
      ),
    );
  }
}
