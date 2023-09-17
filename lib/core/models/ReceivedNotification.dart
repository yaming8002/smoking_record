class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;

  @override
  String toString() {
    return 'ReceivedNotification{id: $id, title: $title, body: $body, payload: $payload}';
  }
}