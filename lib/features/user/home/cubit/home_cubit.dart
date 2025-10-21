import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _firestore = FirebaseFirestore.instance;
Future<void> fetchServices() async {
  try {
    emit(HomeLoading());
    final snapshot = await _firestore.collection('services').get();

  final List<Map<String, dynamic>> services = snapshot.docs.map((doc) {
  return {
    "name": doc['name'] as String,
    "price": "${doc['price'] as num} SAR", // الآن بالريال السعودي
  };
}).toList();



    emit(HomeLoaded(services: services));
  } catch (e) {
    emit(HomeError(message: "Failed to load services: $e"));
  }
}

}
