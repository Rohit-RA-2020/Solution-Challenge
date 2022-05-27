import 'package:flutter/material.dart';
import 'package:decarbonus/screens/add_post_screen.dart';
import 'package:decarbonus/screens/feed_screen.dart';
import 'package:decarbonus/screens/search_screen.dart';

const webScreenSize = 600;
dynamic results;
String? nameStarted = '';

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
];
