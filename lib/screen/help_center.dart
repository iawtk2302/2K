import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/screen/FAQ.dart';

import 'contact_us.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Help Center',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Urbanist'),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryIconTheme.color,
            // labelColor: Colors.black,
            labelStyle: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                fontSize: 16),
            tabs: [
              Tab(
                text: 'FAQ',
              ),
              Tab(
                text: 'Contact us',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FAQTab(),
            ContactUs(),
          ],
        ),
      ),
    );
  }
}
