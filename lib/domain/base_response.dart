

class BaseResponses<T>  {
  final String? message;
  final T? data;

  BaseResponses({
    required this.message,
    required this.data,
  });

}
