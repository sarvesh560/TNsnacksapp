import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import '../../constants/app_text_styles.dart';
import '../home/widgets/snacks_grid.dart';

class SnackGridScreen extends StatelessWidget {
  const SnackGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.offNamed(AppRoutes.home);
        },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        title: Text('All Items', style: AppTextStyles.heading,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(child: SnackGrid()),
      ),
    );
  }
}
