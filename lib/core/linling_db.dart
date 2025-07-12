import 'package:ling_ling_app/models/database/scammers_data.dart';

abstract class LingLingDb {
  Future<void> getUserCountryCode();
  Future<List<ScammersData>> getScammersData();
  Future<int> insert(ScammersData scammerData);
  Future<int> delete(ScammersData scammerData);
  Future<int> upsert(ScammersData scammerData);
  Future<void> createTableSupabase(ScammersData scammerData);
  Future<List<ScammersData>> getScammers();
  Future<ScammersData?> getScammerByPhone(String phoneNumber);
  Future<void> updateVote(int id, int newVote);
  Future<void> deleteScammer(int id);
}
