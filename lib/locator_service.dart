import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_stepik/core/platform/network_info.dart';
import 'package:rick_and_morty_stepik/features/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_stepik/features/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty_stepik/features/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_stepik/features/domain/repositories/person_repository.dart';
import 'package:rick_and_morty_stepik/features/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty_stepik/features/domain/usecases/search_person.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async{
  // BLoC / Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  //Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()
  ));

  sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourceImpl(
    client: http.Client()
  ));

  sl.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(
      sharedPreferences: sl()
  ));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() async => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}