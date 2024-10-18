import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';



/*Абстрактный класс в объектно-ориентированном программировании — базовый класс, который не предполагает
  создания экземпляров. Экземпляр абстрактного класса создать нельзя, поскольку он определён не полностью.
  Абстрактные методы не содержат реализации, их реализуют при наследовании. */
abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}