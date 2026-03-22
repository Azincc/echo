import 'package:flutter_riverpod/flutter_riverpod.dart';

const discoverBranchIndex = 0;
const exploreBranchIndex = 1;
const libraryBranchIndex = 2;

final currentVisibleBranchIndexProvider = StateProvider<int>(
  (ref) => discoverBranchIndex,
);
