import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';

class ContractView extends GetView {
  final String? htmlText;
  final String title;
  const ContractView({Key? key, this.htmlText,required this.title, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.clear)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(
              htmlText!
          ),
        ),
      ),
    );
  }
}
