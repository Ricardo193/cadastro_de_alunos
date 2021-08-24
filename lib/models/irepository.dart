abstract class IRepository<T> {
  Future<List<T>> findAll();

  Future<T> find(int id);

  Future<int> insert(T entity);

  Future<int> update({
    required T entity,
    required String condition,
    required List conditionValues,
  });

  Future<int> remove({
    required String condition,
    required List conditionValues,
  });
}
