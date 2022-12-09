import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FAQTab extends StatefulWidget {
  const FAQTab({super.key});

  @override
  State<FAQTab> createState() => _FAQTabState();
}

class _FAQTabState extends State<FAQTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.black,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
            ItemFAQ(),
          ],
        ),
      ),
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ";

class ItemFAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                      expandIcon: Icons.arrow_drop_down,
                      collapseIcon: Icons.arrow_drop_down,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      // iconColor: Colors.black,
                      iconPadding: EdgeInsets.only(top: 10, right: 10)),
                  header: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        "What is Shoes",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            fontFamily: 'Urbanist'),
                      )),
                  collapsed: const SizedBox(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(
                        color: Colors.grey,
                      ),
                      for (var _ in Iterable.generate(2))
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              loremIpsum,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
