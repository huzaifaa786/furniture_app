class Message {
  String? id;
  String? body;
  String? from_id;
  String? to_id;
  String? file_name;
  String? file_title;
  String? file_type;
  DateTime? dateTime;

  Message(message) {
    id = message['id'];
    body = message['body'];
    from_id = message['from_id'].toString();
    to_id = message['to_id'];
    file_name = message['attachment'] != null ? message['attachment']['file'] ?? '' : '';
    file_title = message['attachment'] != null ? message['attachment']['title'] ?? '' : '';
    file_type = message['attachment'] != null ? message['attachment']['type'] ?? '' : '';
    dateTime = DateTime.parse(message['created_at']).toLocal();
  }
}
