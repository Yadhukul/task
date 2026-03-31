import 'dart:io';
import 'package:flutter/material.dart';

import 'addusersWidegt.dart';
import 'sort_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  SortOption _currentSort = SortOption.all;
  
  final List<Map<String, String>> _users = [
    {
      'name': 'Martin Dokidis',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'name': 'Marilyn Rosser',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'name': 'Cristofer Lipshutz',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'name': 'Wilson Botosh',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Anika Saris',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'name': 'Phillip Gouse',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=6',
    },
    {
      'name': 'Wilson Bergson',
      'age': '34',
      'image': 'https://i.pravatar.cc/150?img=7',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredAndSortedUsers {
    List<Map<String, String>> filtered = _users;

    // Apply search filter
    final searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((user) {
        return user['name']!.toLowerCase().contains(searchQuery);
      }).toList();
    }

    // Apply sorting
    switch (_currentSort) {
      case SortOption.ageElder:
        filtered.sort((a, b) {
          final ageA = int.tryParse(a['age'] ?? '0') ?? 0;
          final ageB = int.tryParse(b['age'] ?? '0') ?? 0;
          return ageB.compareTo(ageA); // Descending order
        });
        break;
      case SortOption.ageYounger:
        filtered.sort((a, b) {
          final ageA = int.tryParse(a['age'] ?? '0') ?? 0;
          final ageB = int.tryParse(b['age'] ?? '0') ?? 0;
          return ageA.compareTo(ageB); // Ascending order
        });
        break;
      case SortOption.all:
      default:
        // Keep original order
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F3),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Nilambur',style: TextStyle(color: Colors.white),),
        leading: const Icon(Icons.location_on,size: 20,color: Colors.white,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) => setState(() {}),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search by name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final result = await showModalBottomSheet<SortOption>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SortBottomSheet(
                        currentSort: _currentSort,
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        _currentSort = result;
                      });
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Users Lists',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredAndSortedUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredAndSortedUsers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundImage: user['image']!.startsWith('http')
                            ? NetworkImage(user['image']!) as ImageProvider
                            : FileImage(File(user['image']!)),
                        backgroundColor: Colors.grey[200],
                      ),
                      title: Text(
                        user['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Age: ${user['age']}'),
                      onTap: () {
                        // handle tap
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, String>>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddUserBottomSheet(),
          );

          if (result != null && result['name'] != null && result['age'] != null) {
            setState(() {
              _users.add({
                'name': result['name']!,
                'age': result['age']!,
                'image': result['imagePath'] ?? 'https://i.pravatar.cc/150?img=${_users.length + 8}',
              });
            });
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
