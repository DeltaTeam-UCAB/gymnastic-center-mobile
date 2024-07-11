abstract class HiveEntityProxy<T> {
  HiveEntityProxy();
  HiveEntityProxy.fromProxiedType(T data);
  T toProxiedType();
}
