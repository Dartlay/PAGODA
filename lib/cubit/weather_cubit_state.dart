// part of 'weather_cubit.dart';

// enum WeatherSatus { initial, loading, succes, failure }

// extension WeatherStatusX on WeatherStatus {
//   bool get isInitial => this == WeatherStatus.initial;
//   bool get isLoading => this == WeatherStatus.loading;
// }

// class WeatherState extends Equatable {
//   WeatherState({
//     this.status = WeatherStatus.initial,
//     this.temperatureUnits = TemperatureUnits.celsius,
//     Weather? weather,
//   }) : weather = weather ?? Weather.empty;
// }

// factory WeatherState.fromJson(Map<String, dynamic> json) =>
//  _$WeatherStateFromJsom(json);


//  final WeatherState status;
//  final Weather weather;
//  final TemperatureUnits temperatureUnits;


//   WeatherState copyWith({

//    WeatherStatus? status,
//    TemperatureUnits? temperatureUnits,
//    Weather? weather,
//   )} {
// return WeatherState(
// status: status ?? this.status,
// temperatureUnits: temperatureUnits ?? this.temperatureUnits,
// weather: weather ?? this.weather,
//  );
// }

//  Map<String, dynamic> toJson() => _$WeatherStateToJson(this.);

//  @override 
//  List<Object?> get props => [status, temperatureUnits, weather]; 

// abstract class WeatherCubitState extends Equatable {
//   const WeatherCubitState();

//   @override
//   List<Object> get props => [];
// }

// class WeatherCubitInitial extends WeatherCubitState {


  
// }
