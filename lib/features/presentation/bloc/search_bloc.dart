import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_stepik/core/error/failure.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/search_event.dart';
import 'package:rick_and_morty_stepik/features/presentation/bloc/search_state.dart';

import '../../domain/usecases/search_person.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson = await searchPerson(SearchPersonParams(query: personQuery)); //вызывается call

    yield failureOrPerson.fold(
            (failure) => PersonSearchError(message: _mapFailureMessage(failure)),
            (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}