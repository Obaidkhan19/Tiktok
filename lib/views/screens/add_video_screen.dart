import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  // PICK VIDEO FROM GALLERY
  pickVideo(ImageSource src, BuildContext context) async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      ),
      );
    }
  }

  // SHOW OPTIONS
  showOptionDialog (BuildContext context){
    return showDialog(context: context, builder: (context) => SimpleDialog(
      children: [
        SimpleDialogOption(
          // pick video from gallery
          onPressed: () => pickVideo(ImageSource.gallery, context),
          child: Row(
            children: [
              Icon(Icons.image),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text('Gallery', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          // pick video from camera
          onPressed: () => pickVideo(ImageSource.camera, context),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text('Camera', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          // cancel
          onPressed: ()=> Navigator.of(context).pop(),
          child: Row(
            children: [
              Icon(Icons.cancel),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text('Cancel', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ]
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()  => showOptionDialog(context),  // SHOW MENUE DIALOG

          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: Center(child: Text('Add Video',
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
