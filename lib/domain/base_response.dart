

class BaseResponses<T>  {
  final String? message;
  final int? code;
  final T? data;

  BaseResponses({
    required this.message,
    required this.data,
    required this.code,
  });

}
