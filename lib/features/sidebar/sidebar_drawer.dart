import 'package:echo/data/models/music_library.dart';
import 'package:echo/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarDrawer extends ConsumerWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLibrary = ref.watch(activeLibraryProvider);
    final asyncLibraries = ref.watch(librariesProvider);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(activeLibrary?.name ?? "No Library"),
            accountEmail: Text(activeLibrary?.username ?? ""),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.music_note),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                onPressed: () {
                  // Navigate to settings or edit current library
                  if (activeLibrary != null) {
                    // context.push('/library/edit/${activeLibrary.id}');
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: asyncLibraries.when(
              data: (libs) {
                if (libs.isEmpty) {
                  return const Center(child: Text("No libraries found."));
                }
                return ListView.builder(
                  itemCount: libs.length,
                  itemBuilder: (context, index) {
                    final lib = libs[index];
                    final isActive = lib.id == activeLibrary?.id;
                    return ListTile(
                      leading: isActive
                          ? const Icon(Icons.check, color: Colors.green)
                          : const Icon(Icons.library_music),
                      title: Text(lib.name),
                      subtitle: Text(lib.isActive ? "Active" : ""),
                      onTap: () {
                        // Switch active
                        // We need a method in repository to set active.
                        // Or just update isActive field.
                        if (!isActive) {
                          // Implementation to switch active
                          _switchLibrary(ref, lib);
                        }
                        Navigator.pop(context); // Close drawer
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Edit
                        },
                      ),
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text("Error: $err")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add New Library"),
            onTap: () {
              // Navigate to add library logic
              // context.push('/library/add');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _switchLibrary(WidgetRef ref, MusicLibrary lib) async {
    final repo = ref.read(libraryRepositoryProvider);
    await repo.setActiveLibrary(lib.id);
  }
}
