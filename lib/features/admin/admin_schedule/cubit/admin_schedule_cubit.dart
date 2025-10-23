import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_schedule_state.dart';

class AdminScheduleCubit extends Cubit<AdminScheduleState> {
  AdminScheduleCubit() : super(const AdminScheduleState());

  final _firestore = FirebaseFirestore.instance;

  Future<void> fetchSchedule() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final usersSnapshot = await _firestore.collection('users').get();

      final Map<String, List<Map<String, dynamic>>> grouped = {};

      for (var userDoc in usersSnapshot.docs) {
        final userData = userDoc.data();

        final userName = userData['name'] ?? 'Unknown User';
        final userAddress = userData['address'] ?? 'No address';
        final bookingsRef = userDoc.reference.collection('bookings');
        final bookingsSnapshot =
            await bookingsRef.orderBy('date', descending: false).get();

        for (var doc in bookingsSnapshot.docs) {
          final data = doc.data();
          DateTime? date;

          final dateField = data['date'];
          if (dateField is Timestamp) {
            date = dateField.toDate();
          } else if (dateField is String) {
            try {
              date = DateTime.parse(dateField);
            } catch (e) {
              date = null;
            }
          }

          final dayName = date != null
              ? _getDayName(date)
              : (data['day'] ?? 'Unknown Day');

          final service = data['service'] ?? 'Unknown Service';
          final status = data['status'] ?? 'Pending';
          final time = data['time'] ?? 'N/A';
          final price = data['price'] ?? 0;
          final address = data['address'] ?? userAddress;

          if (!grouped.containsKey(dayName)) {
            grouped[dayName] = [];
          }

          grouped[dayName]!.add({
            'service': service,
            'status': status,
            'time': time,
            'price': price,
            'userName': userName,
            'address': address,
          });
        }
      }

      emit(state.copyWith(isLoading: false, schedule: grouped));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}
