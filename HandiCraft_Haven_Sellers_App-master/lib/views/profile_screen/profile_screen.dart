import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellersapp/controllers/auth_controller.dart';
import 'package:sellersapp/controllers/profile_controller.dart';
import 'package:sellersapp/services/store_services.dart';
import 'package:sellersapp/views/auth_screen/login_screen.dart';
import 'package:sellersapp/views/messages_screen/messages_screen.dart';
import 'package:sellersapp/views/profile_screen/edit_profilescreen.dart';
import 'package:sellersapp/views/shop_screen/shop_settings_screen.dart';
import 'package:sellersapp/views/widgets/loading_indicator.dart';
import 'package:sellersapp/views/widgets/text_style.dart';
import '../../const/const.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: setting, size: 16.0),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> EditProfileScreen(
              username: controller.snapshotData['vendor_name'],
            ));
          }, icon: const Icon(Icons.edit)),
          TextButton(onPressed: () async{
              await Get.find<AuthController>().signoutMethod(context);
              Get.offAll(()=> const LoginScreen());
          }, child: normalText(text: logout)),
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return loadingIndicator();
            }
            else {
              controller.snapshotData = snapshot.data!.docs[0];

              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imgUrl'] == '' ? Image.asset(imgProduct,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.network(controller.snapshotData['imgUrl'], width: 100).box.roundedFull.clip(Clip.antiAlias).make(),
                    title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                    subtitle: normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(profileButtonsIcons.length, (index) => ListTile(
                        onTap: (){
                          switch (index) {
                            case 0:
                              Get.to(()=> const ShopSettings());
                              break;
                            case 1:
                              Get.to(()=> const MessagesScreen());
                              break;
                            default:
                          }
                        },
                        leading: Icon(profileButtonsIcons[index],color: white,),
                        title: normalText(text: profileButtonsTitles[index]),
                      )),
                    ),
                  )
                ],
              );
            }
          },
      ),
    );
  }
}
