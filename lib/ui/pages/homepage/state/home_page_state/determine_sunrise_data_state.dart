
class DetermineSunriseDataState {
  final bool isLoading;

  DetermineSunriseDataState({required this.isLoading});

  static defaultState() => DetermineSunriseDataState(isLoading: false);

  DetermineSunriseDataState copyWith({bool? isLoading}) {
    return DetermineSunriseDataState(isLoading: isLoading ?? this.isLoading);
  }
}
