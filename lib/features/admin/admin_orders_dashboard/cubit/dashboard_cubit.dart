import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  final _firestore = FirebaseFirestore.instance;

  // 🔹 جلب الخدمات
  Future<void> fetchServices() async {
    emit(state.copyWith(loading: true));
    try {
      final snapshot = await _firestore.collection('services').get();
      final services =
          snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      emit(state.copyWith(loading: false, services: services));
    } catch (e) {
      final msg = _mapErrorToMessage(e);
      emit(state.copyWith(loading: false, error: msg));
    }
  }

  // 🔹 إضافة أو تعديل خدمة
  Future<String> addService(String name, double price) async {
    try {
      final collection = _firestore.collection('services');
      final query = await collection.where('name', isEqualTo: name).get();

      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;
        await collection.doc(docId).update({'price': price});
        await fetchServices();
        return "updated";
      } else {
        await collection.add({'name': name, 'price': price});
        await fetchServices();
        return "added";
      }
    } catch (e) {
      final msg = _mapErrorToMessage(e);
      emit(state.copyWith(error: msg));
      return "error";
    }
  }

  // 🔹 حذف خدمة
  Future<void> deleteService(String id) async {
    try {
      await _firestore.collection('services').doc(id).delete();
      fetchServices();
    } catch (e) {
      final msg = _mapErrorToMessage(e);
      emit(state.copyWith(error: msg));
    }
  }

  // 🧠 دالة لتحويل الأخطاء إلى رسائل مفهومة للمستخدم
  String _mapErrorToMessage(Object e) {
    final error = e.toString();

    if (error.contains("permission-denied")) {
      return "ليس لديك صلاحية للوصول إلى البيانات 🔒";
    } else if (error.contains("unavailable")) {
      return "خدمة الإنترنت غير متاحة حاليًا، حاول لاحقًا 📡";
    } else if (error.contains("not-found")) {
      return "البيانات غير موجودة ❌";
    } else if (error.contains("network")) {
      return "تحقق من اتصال الإنترنت ⚠️";
    } else {
      return "حدث خطأ غير متوقع، حاول مرة أخرى لاحقًا 😕";
    }
  }
}
