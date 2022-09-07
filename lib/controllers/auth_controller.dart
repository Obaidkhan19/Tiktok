import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/user.dart' as model;
import 'package:tiktok/views/screens/auth/home.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();


  // IF USER IS SIGNED IN HE WILL DIRECTLY GO TO HOME SCREEN (MANAGING SESSIONS)
  late Rx<User?> _user;

  // SAME AS ONINIT BUT RUN AFTER 1 FRAME OF ON INIT
  @override
  void onReady() {
    _user =  Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  // _setInitialScreen
  _setInitialScreen(User? user){
    if(user==null){
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() => HomeScreen());
    }
  }


  // Rx = obserable (used to see if value is change or not)
   late Rx<File?> _pickedImage;

   // GETTER OF _pickedImage
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  // PIC IMAGE FROM USER SIGNIN
  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      Get.snackbar('Profile Picture', 'You have sucessfully selected your profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // FUNCTION TO UPLOAD IMAGE TO FIRESTORAGE
  Future<String> _uploadToStorage(File image) async{
    Reference ref= firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

   UploadTask uploadTask = ref.putFile(image);
   TaskSnapshot snap = await uploadTask;

   String downloadUrl = await snap.ref.getDownloadURL();
   return downloadUrl;
  }

  // REGISTERING THE USER
  void registerUser(String username, String email, String password, File? image) async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image!=null){

        // SAVE USER TO AUTHENTICATION AND FIREBASE FIRESTORE(DB)
       UserCredential cred =  await  firebaseAuth.createUserWithEmailAndPassword(
           email: email,
           password: password
       );

       // FUNCTION TO UPLOAD IMAGE TO FIRESTORAGE
       String downloadUrl = await _uploadToStorage(image);
       model.User user = model.User(
           name: username,
         email: email,
         uid: cred.user!.uid,
         profilePhoto: downloadUrl,
       );
       // UPLOADING ON FIREBASE
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
      }

      // IF INPUT FIELDS ARE EMPTY
      else{
        Get.snackbar('Error Creating Account',
            'please enter all the fields');
      }
    }
    catch(e){
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  // LOGIN USER
 void  loginUser(String email, String password) async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        print('log in sucess');
      }else{
        Get.snackbar('Error Logging Account',
            'please enter all the fields');
      }

    }catch(e){
      Get.snackbar('Error Logging in Account', e.toString());
    }
 }

  void signOut()async{
    await firebaseAuth.signOut();
  }
}