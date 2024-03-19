import 'package:password_manager/infrastructure/infrastructure.dart';
import 'package:password_manager/infrastructure/storage.dart';
import 'package:password_manager/models/credential.dart';

import '../models/open_vault.dart';

class VaultApi  {
  final Storage _storage;
  final Protection _protector;

  VaultApi({required storage, required Protection protector})
      : _protector = protector,
        _storage = storage;

  Future<OpenVault> create(
      String masterPassword) async {
    final key = await _protector.createKey(masterPassword);
    final vault = OpenVault(Credential: <Credential>[], key: key);
    await _storage.save(await _protector.encrypt(vault));
    return vault;
  }

  Future<OpenVault> open(String masterPassword) async {
    final vault = _storage.load();
    if (vault == null) throw VaultNotFoundFailure();
    final key = await _protector.recreateKey(vault, masterPassword);
    final credentials = await _protector.decrypt(vault, key);
    return OpenVault(Credential: credentials, key: key);
  }

  Future<bool> save(OpenVault vault) async {
    final encryptedVault = await _protector.encrypt(vault);
    return await _storage.save(encryptedVault);
  }

}