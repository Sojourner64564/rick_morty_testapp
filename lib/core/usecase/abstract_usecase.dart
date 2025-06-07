abstract class AbstractUsecase<Type, Data>{
  Future<Type> call(Data data);
}