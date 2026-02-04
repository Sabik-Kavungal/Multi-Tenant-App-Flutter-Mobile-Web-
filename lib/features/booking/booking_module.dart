import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasf/features/booking/services/booking_api_service.dart';
import 'package:saasf/features/booking/viewmodels/booking_vm.dart';
import 'package:saasf/features/booking/views/bookings_list_page.dart';
import 'package:saasf/features/booking/views/booking_detail_page.dart';
import 'package:saasf/features/booking/views/create_booking_page.dart';
import 'package:saasf/features/catalog/services/service_api_service.dart';

/// Booking Module – Booking Service API
/// List, Detail, Create; Cancel, Complete. Uses Catalog for services in create form.
class BookingModule {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<BookingViewModel>.value(
        value: BookingViewModel(
          BookingApiService(),
          ServiceApiService(),
        ),
      ),
    ];
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/bookings': (context) => const BookingsListPage(),
      '/bookings/create': (context) => const CreateBookingPage(),
      '/booking-detail': (context) => const BookingDetailPage(),
    };
  }
}
