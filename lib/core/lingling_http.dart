abstract class LinglingHttp {
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  });

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers});
}
