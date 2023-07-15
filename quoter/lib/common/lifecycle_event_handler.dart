
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallback;
  final AsyncCallback detachCallback;

  LifecycleEventHandler({required this.resumeCallback, required this.detachCallback});


}