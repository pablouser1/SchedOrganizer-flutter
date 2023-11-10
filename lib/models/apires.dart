class ApiRes<T> {
  final int status;
  final bool success;
  final String msg;
  final T data;

  ApiRes({
    required this.status,
    required this.success,
    required this.msg,
    required this.data,
  });

  factory ApiRes.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) factory,
  ) {
    return ApiRes(
      status: json['status'],
      success: json['success'],
      msg: json['msg'],
      data: factory(json['data']),
    );
  }
}
