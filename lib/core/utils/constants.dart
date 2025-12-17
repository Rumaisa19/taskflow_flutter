// constants.dart
import 'package:flutter/material.dart';


class AppConstants {
// Spacing
static const double padding = 16.0;
static const double margin = 16.0;


// Border radius
static const double borderRadius = 12.0;


// Durations
static const Duration animationDuration = Duration(milliseconds: 300);
static const Duration splashDuration = Duration(milliseconds: 1500);


// Empty state illustration size
static const double emptyStateSize = 200.0;


// Shadow
static const BoxShadow cardShadow = BoxShadow(
color: Colors.black12,
blurRadius: 8,
offset: Offset(0, 4),
);
}