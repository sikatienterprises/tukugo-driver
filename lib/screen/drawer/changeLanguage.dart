import 'package:flutter/material.dart';
import 'package:tukugo/screen/drawer/globals.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  int selectedLanguageIndex = 0; // Default to English (index 0)

  final List<Map<String, String>> languages = [
    {
      'name': 'English',
      'subtitle': 'English',
      'flagAsset':
          'assets/flags/english.png', // Add your PNG flag images to assets folder
    },
    {
      'name': 'Hindi',
      'subtitle': 'हिंदी',
      'flagAsset': 'assets/flags/india.png',
    },
    {
      'name': 'Arabic',
      'subtitle': 'العربية',
      'flagAsset': 'assets/flags/arabic.png',
    },
    {
      'name': 'French',
      'subtitle': 'Français',
      'flagAsset': 'assets/flags/french.png',
    },
    {
      'name': 'German',
      'subtitle': 'Deutsch',
      'flagAsset': 'assets/flags/german.png',
    },
    {
      'name': 'Portuguese',
      'subtitle': 'Português',
      'flagAsset': 'assets/flags/portugues.png',
    },
    {
      'name': 'Turkish',
      'subtitle': 'Türkçe',
      'flagAsset': 'assets/flags/turkish.png',
    },
    {
      'name': 'Dutch',
      'subtitle': 'Nederlands',
      'flagAsset': 'assets/flags/dutch.png',
    },
  ];
  String path = Globals.selectedFlagPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Text(
            'Change Language',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          // Divider line under app bar
          Container(
            height: 1,
            color: Colors.grey[200],
          ),

          // Language list
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = selectedLanguageIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      path = languages[index]['flagAsset'].toString();

                      selectedLanguageIndex = index;
                    });
                    print('Selected language index: $selectedLanguageIndex');
                    print('Selected language: ${language['name']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Flag image
                        Container(
                          width: 32,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 0.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(
                              language['flagAsset']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback container with country code if image not found
                                return Container(
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Text(
                                      language['name']!
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Language text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language['name']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                language['subtitle']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Selection indicator
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isSelected ? Colors.green : Colors.grey[400]!,
                              width: 2,
                            ),
                            color:
                                isSelected ? Colors.green : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Save button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Globals.selectedFlagPath = path;
                  Navigator.pop(context, selectedLanguageIndex);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF), // iOS blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage example:
// To navigate to this page:
/*
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ChangeLanguagePage(),
  ),
).then((selectedIndex) {
  if (selectedIndex != null) {
    print('User selected language at index: $selectedIndex');
    // Handle the selected language index
  }
});
*/
