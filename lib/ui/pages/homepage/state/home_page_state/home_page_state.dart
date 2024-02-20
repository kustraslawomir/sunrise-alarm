import '../../../../../domain/usecase/datetime/date_time_formatter.dart';

class HomePageState {
  final DateTime? localSunriseDate;

  final String? location;

  final bool isLoading;

  HomePageState(
      {required this.localSunriseDate,
      required this.location,
      required this.isLoading});

  static empty() =>
      HomePageState(localSunriseDate: null, location: null, isLoading: false);

  HomePageState copyWith(
      {DateTime? localSunriseDate, String? location, bool? isLoading}) {
    return HomePageState(
        localSunriseDate: localSunriseDate ?? this.localSunriseDate,
        location: location ?? this.location,
        isLoading: isLoading ?? this.isLoading);
  }

  String localSunriseDateHHmm() {
    final date = localSunriseDate;
    if (date == null) {
      throw Exception('local sunrise date is null');
    }
    return DateTimeFormatter.toHHmm(date);
  }
}
