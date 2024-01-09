part of 'booking_checkout_cubit.dart';

class BookingCheckoutState extends Equatable {
  final LoadStatus getSchedulerStatus;
  final SchedulerDetailResponse? schedulerDetail;

  final LoadStatus createBookingStatus;
  final String? createBookingMessage;
  final PaymentMethod? paymentMethod;

  final LoadStatus createVnPayPaymentStatus;
  final String? createVnPayPaymentMessage;
  final Uri? vnPayPaymentUrl;

  const BookingCheckoutState({
    this.getSchedulerStatus = LoadStatus.initial,
    this.schedulerDetail,
    this.createBookingStatus = LoadStatus.initial,
    this.createBookingMessage,
    this.paymentMethod,
    this.createVnPayPaymentStatus = LoadStatus.initial,
    this.createVnPayPaymentMessage,
    this.vnPayPaymentUrl,
  });

  BookingCheckoutState copyWith({
    LoadStatus? getSchedulerStatus,
    SchedulerDetailResponse? schedulerDetail,
    LoadStatus? createBookingStatus,
    String? createBookingMessage,
    PaymentMethod? paymentMethod,
    LoadStatus? createVnPayPaymentStatus,
    String? createVnPayPaymentMessage,
    Uri? vnPayPaymentUrl,
  }) {
    return BookingCheckoutState(
      getSchedulerStatus: getSchedulerStatus ?? this.getSchedulerStatus,
      schedulerDetail: schedulerDetail ?? this.schedulerDetail,
      createBookingStatus: createBookingStatus ?? this.createBookingStatus,
      createBookingMessage: createBookingMessage ?? this.createBookingMessage,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createVnPayPaymentStatus: createVnPayPaymentStatus ?? this.createVnPayPaymentStatus,
      createVnPayPaymentMessage: createVnPayPaymentMessage ?? this.createVnPayPaymentMessage,
      vnPayPaymentUrl: vnPayPaymentUrl ?? this.vnPayPaymentUrl,
    );
  }

  @override
  List<Object?> get props => [
        getSchedulerStatus,
        schedulerDetail,
        createBookingStatus,
        createBookingMessage,
        paymentMethod,
        createVnPayPaymentStatus,
        createVnPayPaymentMessage,
        vnPayPaymentUrl,
      ];
}
