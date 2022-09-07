import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{
  // compress video
  _compressVideo(String videoPath)async{
  final compressedvideo=  await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.MediumQuality
    );
  return compressedvideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async{
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }


  _getThumbnail(String videoPath)async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
  // upload image/thumbnail to storage
  Future<String>_uploadImageToStorage(String id, String videoPath) async{
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }


  // function upload  video
  uploadVideo(String songName, String caption, String videoPath) async{
    try{
      String uid= firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firestore.collection('users').doc(uid).get();

      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;

      // compress video and upload video
     String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);

     // upload image/thumbnail to storage
     String thumbnail = await _uploadImageToStorage("Video $len", videoPath);
     
     Video video = Video(username: (userDoc.data()! as Map<String, dynamic>)['name'],
         uid: uid,
         id: "video $len",
         likes: [],
         commentCount: 0,
         shareCount: 0,
         songname: songName,
         caption: caption,
         videoUrl: videoUrl,
         profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
       thumbnail: thumbnail,
     );

     await firestore.collection('videos').doc('video $len').set(video.toJson(),);
    Get.back();
    }
   catch(e){
      Get.snackbar("Error uploading video", e.toString(),);
        }
  }
}