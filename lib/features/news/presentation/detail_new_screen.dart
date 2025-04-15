  import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';

  class NewsDetailScreen extends StatelessWidget {
    final String? model;
    const NewsDetailScreen({super.key, required this.model});

    @override
    Widget build(BuildContext context) {
      final bool saved = true;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1619266465172-02a857c3556d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dm9sY2Fub3xlbnwwfHwwfHx8MA%3D%3D',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: FloatingActionButton(
                        heroTag: "back",
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        mini: true,
                        child: Icon(Icons.navigate_before_sharp, color: Theme.of(context).colorScheme.primary,),
                      )
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          heroTag: "bookmark",
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          mini: true,
                          child: saved? SvgPicture.asset("assets/bookmark_saved.svg") : SvgPicture.asset("assets/bookmark.svg"),
                        ),
                        const SizedBox(width: 12),
                        FloatingActionButton(
                          heroTag: "share",
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          mini: true,
                          child: Icon(Icons.share, color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "25 Januari 2020",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        const Text.rich(
                          TextSpan(
                            text: 'Author - ',
                            style: TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Riski Prasetyo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0070F3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
