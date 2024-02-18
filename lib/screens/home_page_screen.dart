import 'package:accomation_assignment/models/parameter_models.dart';
import 'package:accomation_assignment/services/application_providers.dart';
import 'package:accomation_assignment/services/future_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    var userLocationFuture = ref.watch(getUserLocationFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Data"),
        elevation: 10,
        scrolledUnderElevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(applicationModelProvider.notifier).switchDarkMode();
            },
            icon: Icon(ref.watch(applicationModelProvider).darkMode ? Icons.light_mode : Icons.dark_mode),
          )
        ],
      ),
      body: userLocationFuture.when(
        data: (value) {
          var position = value.position;
          var error = value.error;

          if (position == null) {
            debugPrint("position is null");
            return Center(
              child: Text(error ?? "Error occurred! Pleas check your network connection and retry!"),
            );
          }

          var getWeatherFuture = ref.watch(getWeatherFutureProvider(
            GetWeatherFPParams(
              lat: position.latitude,
              long: position.longitude,
            ),
          ));

          return getWeatherFuture.when(
            data: (value) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Lat: ${value.coord.lat}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Long: ${value.coord.lon}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      value.weather.firstOrNull?.main ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${(value.main.temp - 273.15).toStringAsFixed(2)} °c",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (e, s) {
              debugPrint("Error:$e, Stack:$s");
              return const Center(
                child: Text(
                  "Error occurred! Pleas check your network connection and retry!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
        error: (e, s) {
          debugPrint("Error:$e, Stack:$s");
          return const Center(
            child: Text(
              "Error occurred! Pleas check your network connection and retry!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
