import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    final photoUrl = firebaseAuth.currentUser?.photoURL;
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.sp),
      // No remote placeholder: when there is no photo, render the offline
      // LineIcon so the avatar stays reliable without a network round-trip.
      child: photoUrl == null
          ? LineIcon.user(size: 10.w)
          : CachedNetworkImage(
              imageUrl: photoUrl,
              placeholder: (BuildContext context, String url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  LineIcon.user(size: 10.w),
            ),
    );
  }
}
