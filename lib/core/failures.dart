abstract class Failure implements Exception {
  String get message;
}

class OpenVaultFailure extends Failure {
  @override
  // TODO: implement message
  String get message => """
Unable to open vault.
Did you type the correct password?
  """;
}

class VaultNotFoundFailure extends Failure{
  @override
  // TODO: implement message
  String get message =>  "Vault not found.";
}

class SaveVaultFailure extends Failure {
  @override
  // TODO: implement message
  String get message => """
Unable to save vault.
Please try again or check logs.
""";
}

class UnknownVaultFailure extends Failure {
  @override
  // TODO: implement message
  String get message => """
An unknown error has occurred.
See log for details.
""";
}

