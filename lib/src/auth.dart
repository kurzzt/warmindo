// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// A mock authentication service
class WarungAuth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is WarungAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;

  static WarungAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<WarungAuthScope>()!
      .notifier!;
}

class WarungAuthScope extends InheritedNotifier<WarungAuth> {
  const WarungAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });
}
