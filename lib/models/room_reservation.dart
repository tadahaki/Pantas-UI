class RoomReservation {
  final String id;
  final String roomName;
  final DateTime reservationDate;
  final String startTime;
  final String endTime;
  final String status; // e.g., pending, approved, rejected
  final DateTime createdAt;

  RoomReservation({
    required this.id,
    required this.roomName,
    required this.reservationDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
  });
}
