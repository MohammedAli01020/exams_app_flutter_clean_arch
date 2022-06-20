
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

