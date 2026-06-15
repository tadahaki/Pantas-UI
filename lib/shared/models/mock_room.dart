class MockRoom {
  final String id;
  final String name;
  final String building;
  final int capacity;
  final String status;
  final List<String> availableSlots;

  const MockRoom({
    required this.id,
    required this.name,
    required this.building,
    required this.capacity,
    required this.status,
    required this.availableSlots,
  });
}
