import 'dart:io';

dynamic fileForPath(String path) => File(path);

bool fileExistsSync(String path) => File(path).existsSync();

Future<bool> fileExists(String path) => File(path).exists();

Future<int> fileLength(String path) => File(path).length();
