//ValueNotifier: hold the data
//ValueListenableBuilder: listens to data(dont need setState())

import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(true);
