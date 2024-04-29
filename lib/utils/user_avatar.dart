import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'string_app.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.sp),
      child: CachedNetworkImage(
        imageUrl: firebaseAuth.currentUser?.photoURL ?? AppString.appUserIcon,
        placeholder: (BuildContext context, String url) =>
            const CircularProgressIndicator(),
        errorWidget: (BuildContext context, String url, dynamic error) =>
             LineIcon.user(size: 5.sp,),
      ),
    );
  }
}
