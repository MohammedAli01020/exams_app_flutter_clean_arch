
import 'package:flutter/material.dart';

import 'app.dart';
import 'bloc_observer.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();


  BlocOverrides.runZoned(() {

      runApp(const ExamsApp());

    },
    blocObserver: AppBlocObserver(),
  );
}



// final pref = di.sl<SharedPreferences>();
// String initRoutes = Routes.initialRoute;
//
//
// if (pref.getString(AppStrings.cachedCurrentUser) != null) {
//   initRoutes = Routes.examsRoute;
//   Constants.currentUser = CurrentUserModel.fromJson(jsonDecode(pref.getString(AppStrings.cachedCurrentUser)!));
// }