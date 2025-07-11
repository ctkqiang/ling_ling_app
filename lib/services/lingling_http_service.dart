import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ling_ling_app/core/lingling_http.dart';
import 'package:logger/logger.dart';

class Http extends LinglingHttp {
  final Logger logger = Logger();

  final String? baseUrl;
  final Duration timeout;
  final Future<String?> Function()? getToken;
  final void Function()? onUnauthorized;

  /// HTTP 客户端实例，用于发起网络请求
  Http(
    this.baseUrl, {
    this.timeout = const Duration(seconds: 10),
    this.getToken,
    this.onUnauthorized,
  });

  /// 发送 DELETE 请求到指定端点
  ///
  /// [endpoint] 请求路径（追加到baseUrl后）
  /// [query] 可选的查询参数
  /// [headers] 可选的请求头
  ///
  /// 返回处理后的响应数据
  /// 超时时间由timeout字段控制
  @override
  Future delete(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final mergedHeaders = await _mergeHeaders(headers);
    final res = await http.delete(uri, headers: mergedHeaders).timeout(timeout);

    if (kDebugMode) {
      logger.d("[LinglingHttp] DELETE $uri\n${res.body}");
    }

    return _handleResponse(res);
  }

  /// 发起GET请求
  ///
  /// [endpoint] 请求路径
  /// [query] 可选查询参数
  /// [headers] 可选请求头
  ///
  /// 返回处理后的响应数据
  /// 超时时间由timeout字段控制
  @override
  Future get(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: query);

    final mergedHeaders = await _mergeHeaders(headers);
    final res = await http.get(uri, headers: mergedHeaders).timeout(timeout);

    if (kDebugMode) {
      logger.d("[LinglingHttp] GET $uri\n${res.body}");
    }

    return _handleResponse(res);
  }

  /// 发送一个POST请求到指定的端点。
  ///
  /// [endpoint] 要请求的API端点路径。
  /// [headers] 可选的请求头信息。
  /// [body] 可选的请求体内容。
  /// 返回一个包含响应结果的Future。
  /// 请求超时时间由[timeout]字段控制。
  /// 会自动合并基础请求头与传入的[headers]。
  /// 请求体会被自动转换为JSON格式。
  @override
  Future post(String endpoint, {Map<String, String>? headers, body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');

    final mergedHeaders = await _mergeHeaders(headers);

    final res = await http
        .post(uri, headers: mergedHeaders, body: jsonEncode(body))
        .timeout(timeout);

    if (kDebugMode) {
      logger.d("[LinglingHttp] POST $uri\n${res.body}");
    }

    return _handleResponse(res);
  }

  /// 发送一个 PUT 请求到指定的 [endpoint]
  ///
  /// [headers] 可选的请求头，会与默认头合并
  /// [body] 可选的请求体，会自动编码为 JSON
  /// 返回处理后的响应数据
  /// 超时时间由 [timeout] 控制
  @override
  Future put(String endpoint, {Map<String, String>? headers, body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final mergedHeaders = await _mergeHeaders(headers);
    final res = await http
        .put(uri, headers: mergedHeaders, body: jsonEncode(body))
        .timeout(timeout);

    if (kDebugMode) {
      logger.d("[LinglingHttp] PUT $uri\n${res.body}");
    }

    return _handleResponse(res);
  }

  /// 合并请求头信息，包含默认头信息和可选的授权令牌
  ///
  /// [custom] 可选的自定义头信息，将被合并到默认头信息中
  /// 返回合并后的头信息 Map，包含 Content-Type、Accept 和可能的 Authorization
  Future<Map<String, String>> _mergeHeaders(Map<String, String>? custom) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = await getToken?.call();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (custom != null) headers.addAll(custom);
    return headers;
  }

  /// 响应处理
  dynamic _handleResponse(http.Response res) {
    if (kDebugMode) {
      print('[HTTP ${res.statusCode}] ${res.request?.url}');
      print('[Response] ${res.body}');
    }

    switch (res.statusCode) {
      case 200:
      case 201:
        return _tryDecode(res.body);
      case 204:
        return null;
      case 400:
        throw HttpException('Bad request', uri: res.request?.url);
      case 401:
        onUnauthorized?.call();
        throw HttpException('Unauthorized', uri: res.request?.url);
      case 403:
        throw HttpException('Forbidden', uri: res.request?.url);
      case 404:
        throw HttpException('Not found', uri: res.request?.url);
      case 500:
      default:
        throw HttpException(
          'Server error ${res.statusCode}',
          uri: res.request?.url,
        );
    }
  }

  dynamic _tryDecode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }
}
