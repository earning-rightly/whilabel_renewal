import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/util_views/date_picker/date_picker_view_model.dart';

import '../../../design_guide_managers/color_manager.dart';

class DatePickerView extends ConsumerWidget {

  final DatePickerViewModel viewModel;
  final TextEditingController textController = TextEditingController();

   DatePickerView({
    required this.viewModel,
});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(viewModel.provider);
    final now = DateTime.now().year - 19;

    return GestureDetector(
      child: TextFormField(
        style: TextStylesManager.regular16,
        keyboardType: TextInputType.none,
        showCursor: false,
        enableInteractiveSelection: false,
        controller: textController,
        onTap: () {
          showDatePicker(context,ref);
        },
        decoration: InputDecoration(
          hintText: "${now}-01-01",
          hintStyle: const TextStyle(color: ColorsManager.gray200),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1, color: ColorsManager.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: ColorsManager.red),
          ),

          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }



  showDatePicker(BuildContext context,WidgetRef ref) async {
    final state = ref.watch(viewModel.provider);

    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  color: ColorsManager.black200,
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                          TextStylesManager.createHadColorTextStyle(
                              "R24", ColorsManager.white),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.parse("${(DateTime.now().year - 19)}-01-01"),
                        minimumYear: 1920,
                        maximumYear: (DateTime.now().year - 19),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime date) {
                          ref.read(viewModel.provider.notifier).updateDateTime(date);
                          textController.text = "${date.year}-${date.month}-${date.day}";;
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("완료", style: TextStylesManager.medium16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}