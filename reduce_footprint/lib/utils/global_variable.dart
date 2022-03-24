import 'package:flutter/material.dart';
import 'package:reduce_footprint/screens/add_post_screen.dart';
import 'package:reduce_footprint/screens/feed_screen.dart';
import 'package:reduce_footprint/screens/search_screen.dart';

const webScreenSize = 600;
String? emaill;
var results;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
];
