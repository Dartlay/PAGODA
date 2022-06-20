// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pagoda/Block/bloc/homepage_event.dart';
// import 'package:pagoda/Block/bloc/homepage_state.dart';
// import 'package:pagoda/Location/Usecases/weather_params.dart';
// import 'package:pagoda/Location/get_weather.dart';
// import 'package:pagoda/Location/location.dart';
// import 'package:pagoda/Utilities/weather.dart';

// const String LOCATION_FAILURE_MESSAGE = "Unable to get the Location";
// const String SERVER_FAILURE_MESSAGE = "Unable to get data from database";

// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final GetWeather getWeather;
//   final GetLatLong getLatLong;
//   @override
//   WeatherState get initialState => Empty();

//   WeatherBloc({
//     required this.getLatLong,
//     required this.getWeather,
//   }) : super(Empty()) {
//     on<WeatherEvent>((event, emit) {});
//     on<GetWeatherForLatLong>((event, emit) async {
//       final latLongEither = await getLatLong.getLatLong();

//       await latLongEither.fold((failure) {
//         emit(Error(message: LOCATION_FAILURE_MESSAGE));
//       }, (latLong) async {
//         emit(Loading());
//         final failureOrWeather =
//             await getWeather(WeatherParams(latLong: latLong));
//         failureOrWeather.fold((failure) {
//           emit(Error(message: SERVER_FAILURE_MESSAGE));
//         }, (weather) {
//           emit(Loaded(weather: weather));
//         });
//       });
//     });
//   }
// }
