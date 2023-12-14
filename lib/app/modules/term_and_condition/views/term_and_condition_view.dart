import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';

import '../controllers/term_and_condition_controller.dart';

class TermAndConditionView extends GetView<TermAndConditionController> {
  const TermAndConditionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: const CustomAppBar(title: 'Term and Condition')),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder<String>(
                  future: controller.getTermAndCondition(),
                  builder: (context, snapData) {
                    if (snapData.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return HtmlWidget(snapData.data.toString());
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
