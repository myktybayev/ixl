import 'package:flutter/material.dart';
import 'package:ixl/features/presentation/pages/profile/components/body.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProfileBody(),
    );
  }
}