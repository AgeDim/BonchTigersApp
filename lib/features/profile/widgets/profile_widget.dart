import 'dart:io';
import 'package:bonch_tigers_app/features/profile/widgets/profile_widget_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixel_snap/pixel_snap.dart';
import '../../../styles/style_library.dart';

class ProfileWidget extends StatefulWidget {
  final String? role;

  const ProfileWidget({super.key, required this.role});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? _imageFile;
  String? _imageUrl;
  late ProfileWidgetPresenter _presenter;

  void setImageFile(File? imageFile) {
    setState(() {
      _imageFile = imageFile;
    });
  }

  void setImageUrl(String? imageUrl) {
    setState(() {
      _imageUrl = imageUrl;
    });
  }

  File? getImageFile() {
    return _imageFile;
  }

  @override
  void initState() {
    super.initState();
    _presenter = ProfileWidgetPresenter(
        setImageFile: setImageFile,
        setImageUrl: setImageUrl,
        getImageFile: getImageFile);
    _presenter.getUserImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    final ps = PixelSnap.of(context);
    return Container(
      padding: EdgeInsets.all(10.pixelSnap(ps)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.pixelSnap(ps))),
        border: Border.all(color: StyleLibrary.color.orange),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10.pixelSnap(ps)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.pixelSnap(ps)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.pixelSnap(ps)),
              child: _imageUrl != null
                  ? Image.network(
                      _imageUrl!,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    )
                  : Icon(
                      Icons.account_box_outlined,
                      size: 100.pixelSnap(ps),
                      color: Colors.grey,
                    ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15.pixelSnap(ps)),
                      child: Text(
                        '${FirebaseAuth.instance.currentUser!.displayName}',
                        style: StyleLibrary.text.black20,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      '${widget.role}',
                      style: StyleLibrary.text.lightGray16,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => {_presenter.pickImage()},
                    child: SizedBox(
                      width: 30.pixelSnap(ps),
                      height: 30.pixelSnap(ps),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 30.pixelSnap(ps),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
