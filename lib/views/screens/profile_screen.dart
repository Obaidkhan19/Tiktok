import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/profile_controller.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatefulWidget {

  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
    init: ProfileController(),
      builder: (controller){
      if(controller.user.isEmpty){
        return const Center(child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.black12,
          leading: const Icon(
          Icons.person_add_alt_1_outlined,
      ),
      actions: const [
      Icon(Icons.more_horiz),
      ],
      title: Text(
      controller.user['name'],
      style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      ),
      ),
          ),

        body:  SafeArea(
        child: SingleChildScrollView(
        child: Column(
        children: [
      SizedBox(
      child: Column(
      children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: controller.user['profilePhoto'],
              height: 100,
              width: 100,
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
              const Icon(
                Icons.error,
              ),
            ),
          )
        ],
      ),
      SizedBox(height: 15,),

      // FOLLOWING ROW
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Column(
      children: [
      Text(
        controller.user['following'],
      style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 5,),
      const Text(
      'following',
      style:  TextStyle(
      fontSize: 14,
      ),
      ),
      ],
      ),

      Container(
      color: Colors.black54,
      width: 1,
      height: 15,
      margin: EdgeInsets.symmetric(horizontal: 15,),
      ),

      Column(
      children: [
      Text(
      controller.user['Followers'],
      style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 5,),
      const Text(
      'Followers',
      style:  TextStyle(
      fontSize: 14,
      ),
      ),
      ],
      ),
      Container(
      color: Colors.black54,
      width: 1,
      height: 15,
      margin: EdgeInsets.symmetric(horizontal: 15,),
      ),

      Column(
      children: [
      Text(
        controller.user['likes'],
      style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 5,),
        const Text(
      'Likes',
      style:  TextStyle(
      fontSize: 14,
      ),
      ),
      ],
      ),
      ],
      ),

      SizedBox(height: 15,),

      Container(
      width: 140,
      height: 47,
      decoration: BoxDecoration(
      border: Border.all(
      color: Colors.black12
      ),
      ),
      child: Center(
      child: InkWell(
      onTap: (){
        if( widget.uid == authController.user.uid ){
          authController.signOut();
        } else{
          controller.followUser();
        }
      },
      child: Text(
      widget.uid == authController.user.uid ?  'Sign Out'
          : controller.user['isFollowing ']
          ? 'Unfollow'
          : 'Follow',
        style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15
      ),
      ),
      ),
      ),
      ),
          const SizedBox(
            height: 25,
          ),
      //  VIDEO LIST
          GridView.builder(
            shrinkWrap: true,
            itemCount:controller.user['thumbnails'].length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 img in a row
                  childAspectRatio:1,
                  crossAxisSpacing: 5,
              ),
            itemBuilder: (context, index){
                String thumbnail= controller.user['thumbnails'][index];
                return CachedNetworkImage(imageUrl: thumbnail, fit: BoxFit.cover);
            },
          )
      ],
      ),
        ),
      ],
        ),
      ),
        ),
      );
      });
  }
}
