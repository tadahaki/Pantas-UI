import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/mock_room.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../rooms/widgets/time_slot_chip.dart';

class RoomReservationScreen extends StatefulWidget {
  const RoomReservationScreen({super.key});

  @override
  State<RoomReservationScreen> createState() => _RoomReservationScreenState();
}

class _RoomReservationScreenState extends State<RoomReservationScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedRoom = 'Room A';
  String selectedSlot = '9:00 AM';
  final int studentCount = 1;
  final List<String> studentNames = ['Jane Doe'];

  final rooms = const [
    MockRoom(
      id: 'roomA',
      name: 'Study Room A',
      building: 'Main Library',
      capacity: 6,
      status: 'Available',
      availableSlots: ['9:00 AM', '11:00 AM', '2:00 PM'],
    ),
    MockRoom(
      id: 'roomB',
      name: 'Group Room B',
      building: 'Annex',
      capacity: 8,
      status: 'Booked',
      availableSlots: ['10:00 AM', '1:00 PM', '4:00 PM'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Reservation')),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Choose a room', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: rooms.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoom = room.name;
                        });
                      },
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedRoom == room.name ? AppColors.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(room.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 8),
                            Text(room.building, style: const TextStyle(color: AppColors.textMuted)),
                            const SizedBox(height: 12),
                            StatusBadge(
                              label: room.status,
                              color: room.status == 'Available' ? AppColors.success : AppColors.danger,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Select date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedDate.toLocal().toString().split(' ')[0]),
                      const Icon(Icons.calendar_today, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Choose a time slot', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: rooms
                    .firstWhere((room) => room.name == selectedRoom)
                    .availableSlots
                    .map((slot) => TimeSlotChip(
                          label: slot,
                          selected: slot == selectedSlot,
                          onTap: () {
                            setState(() {
                              selectedSlot = slot;
                            });
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              const Text('Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.group, color: AppColors.primary),
                        SizedBox(width: 12),
                        Text('1 student selected', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: studentNames
                          .map(
                            (name) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(name, style: const TextStyle(color: AppColors.textMuted)),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.go('/room_reservation_details');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  minimumSize: const Size.fromHeight(52),
                ),
                child: const Text('Submit Reservation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
