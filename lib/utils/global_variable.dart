import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/feed_user.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/feedback_user.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/history_user.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/profile_user.dart';

List<Widget> dashboardItems = [
  const FeedUser(),
  const FeedbackUser(),
  const HistoryUser(),
  const ProfileUser()
];
