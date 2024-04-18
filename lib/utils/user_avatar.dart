import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'string_app.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: firebaseAuth.currentUser?.photoURL ?? AppString.appUserIcon,
      placeholder: (BuildContext context, String url) =>
          const CircularProgressIndicator(),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
    );
  }
}
