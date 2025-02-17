import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/search_bloc.dart';
import 'package:rick_and_morty_stepik/locator_service.dart' as di;

import 'features/presentation/pages/person_screen.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(create: (context) => sl<PersonListCubit>()),
          BlocProvider<PersonSearchBloc>(create: (context) => sl<PersonSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            dialogBackgroundColor: Colors.black,
            scaffoldBackgroundColor: Colors.grey,
          ),
          home: HomePage(),
        ));
  }
}
