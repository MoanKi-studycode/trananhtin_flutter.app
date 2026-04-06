import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Stream<List<T>> getDataStream<T>({
  required String table,
  required List<String> ids,
  required T Function(Map<String, dynamic>) fromMap,
}) {
  final supabase = Supabase.instance.client;
  var stream = supabase.from(table).stream(primaryKey: ids);
  return stream.map((event) => event.map((e) => fromMap(e)).toList());
}

Future<Map<int, T>> getMapData<T>({
  required String table,
  required T Function(Map<String, dynamic> map) fromMap,
  required int Function(T t) getId,
}) async {
  final data = await supabase.from(table).select();
  var interable = data.map((e) => fromMap(e));
  return Map.fromIterable(interable, key: (e) => getId(e), value: (e) => e);
}

listenDataChange<T>(
  Map<int, T> maps, {
  Function()? updateUI,
  required String chanel,
  required String table,
  required T Function(Map<String, dynamic>) fromMap,
  required int Function(T t) getId,
  String scheme = "public",
}) {
  supabase
      .channel(chanel)
      .onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: scheme,
        table: table,
        callback: (payload) {
          //print('Change received: ${payload.toString()}');
          switch (payload.eventType) {
            case PostgresChangeEvent.insert:
            case PostgresChangeEvent.update:
              {
                T t = fromMap(payload.newRecord);
                maps[getId(t)] = t;
                updateUI?.call();
                break;
              }
            case PostgresChangeEvent.delete:
              {
                maps.remove(payload.oldRecord['id']);
                updateUI?.call();
                break;
              }
            default:
              {}
          }
        },
      )
      .subscribe();
}
