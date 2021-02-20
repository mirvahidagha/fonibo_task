// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$TaskApiService extends TaskApiService {
  _$TaskApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = TaskApiService;

  Future<Response> getTasks() {
    final $url = '/tasks.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
