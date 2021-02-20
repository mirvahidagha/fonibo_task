import 'package:chopper/chopper.dart';

part 'task_api_service.chopper.dart';

@ChopperApi(baseUrl: '/tasks.json')
abstract class TaskApiService extends ChopperService {
  @Get()
  Future<Response> getTasks();

  static TaskApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://cdn.fonibo.com/challenges',
      services: [_$TaskApiService()],
      converter: JsonConverter(),
    );
    return _$TaskApiService(client);
  }
}
