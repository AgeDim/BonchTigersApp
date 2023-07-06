import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidgetPresenter {
  final Function(File? imageFile) setImageFile;
  final Function(String? imageUrl) setImageUrl;
  final Function() getImageFile;

  ProfileWidgetPresenter(
      {required this.setImageFile,
      required this.setImageUrl,
      required this.getImageFile});

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setImageFile(File(pickedImage.path));
      await _uploadImageToStorage();
    }
  }

  Future<void> getUserImageUrl() async {
    try {
      final ref = FirebaseStorage.instance
          .ref('${FirebaseAuth.instance.currentUser!.uid}/avatar.png');
      final url = await ref.getDownloadURL();
      setImageUrl(url);
    } catch (e) {
      print('Error getting user image URL: $e');
    }
  }

  Future<void> _uploadImageToStorage() async {
    if (getImageFile() != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageRef =
            FirebaseStorage.instance.ref().child('${user.uid}/avatar.png');
        final uploadTask = storageRef.putFile(getImageFile());
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        setImageUrl(downloadUrl);
      }
    }
  }
}
