import '../data/mock_data.dart';
import '../models/patient_model.dart';
import '../models/game_model.dart';
import '../models/activity_model.dart';
import '../models/reminder_model.dart';
import '../models/progress_model.dart';

/// Abstract service contract for future API/backend integration
abstract class IDataService {
  Future<PatientModel> getPatientProfile();
  Future<List<GameModel>> getGames();
  Future<List<ReminderModel>> getReminders();
  Future<List<ActivityModel>> getDailyActivities();
  Future<ProgressModel> getProgress();
}

/// In-memory mock implementation of IDataService for Phase 1 prototype
class MockDataService implements IDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  @override
  Future<PatientModel> getPatientProfile() async {
    return MockData.defaultPatient;
  }

  @override
  Future<List<GameModel>> getGames() async {
    return List.from(MockData.initialGames);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    return List.from(MockData.initialReminders);
  }

  @override
  Future<List<ActivityModel>> getDailyActivities() async {
    return List.from(MockData.initialActivities);
  }

  @override
  Future<ProgressModel> getProgress() async {
    return MockData.initialProgress;
  }
}
