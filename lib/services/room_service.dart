import '../models/room_reservation.dart';

// Stub for room reservation service
// Will be implemented with actual API calls
class RoomService {
  static final RoomService _instance = RoomService._internal();

  factory RoomService() {
    return _instance;
  }

  RoomService._internal();

  Future<List<String>> getAvailableRooms(DateTime date) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<List<String>> getAvailableTimeSlots(String room, DateTime date) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<bool> submitReservation(
    String room,
    DateTime date,
    String startTime,
    String endTime,
  ) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<List<RoomReservation>> getUserReservations() async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}
