class TrainInfo {
  final String trainNumber;
  final String trainName;
  final List<String> runDays;
  final String fromStation;
  final String toStation;
  final String fromStationName;
  final String toStationName;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final int durationInHours;

  TrainInfo({
    required this.durationInHours,
    required this.trainNumber,
    required this.trainName,
    required this.runDays,
    required this.fromStation,
    required this.toStation,
    required this.fromStationName,
    required this.toStationName,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
  });
}
