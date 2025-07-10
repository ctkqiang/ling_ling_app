import 'package:ling_ling_app/models/contacts.dart';

abstract class LinglingScamDetection {
  /// 数据库操作接口
  ///
  /// [phoneNumber] 电话号码查询记录数
  Future<int> recordCount(String phoneNumber);

  /// 将联系人信息写入数据库
  ///
  /// [contacts] 要写入的联系人对象
  Future<void> writeIntoDatabase(Contacts contacts);

  /// 获取诈骗联系人列表
  ///
  /// [pagination] 分页数量，默认为30条
  /// 返回联系人列表
  Future<List<Contacts>> listScammersContacts({int pagination = 30});

  /// 请求从数据库中删除联系人
  ///
  /// [contacts] 要删除的联系人对象
  Future<void> requestToDeleteFromDatabase(Contacts contacts);

  Future<void> flagContactAsScam(Contacts contacts);
}
