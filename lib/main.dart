import 'package:cosmere_us/data/bloc/book_bloc.dart';
import 'package:cosmere_us/data/repository/book_repository.dart';
import 'package:cosmere_us/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart';

import 'package:responsive_framework/responsive_framework.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BookRepository(),
      child: BlocProvider(
        create: (context) =>
            BookBloc(RepositoryProvider.of<BookRepository>(context))
              ..add(LoadBookEvent()),
        child: MaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              defaultScale: true,
              minWidth: 480,
              defaultName: MOBILE,
              breakpoints: [],
              background: Container(color: Colors.black)),
          debugShowCheckedModeBanner: false,
          home: const Home(),
        ),
      ),
    );
  }
}
