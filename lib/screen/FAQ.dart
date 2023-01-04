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
          children: const <Widget>[
            ItemFAQ(
              title: 'What is No Rush shipping?',
              content:
                  'No Rush shipping means exactly that: no rush. We decided to take the benefits of ground-only shipping and make it available for anyone. Why? Because, on average, ground-only shipping is less carbon-intensive than air freight shipping.',
            ),
            ItemFAQ(
              title: 'Which carrier is delivering my order?',
              content:
                  'When you track your package(s), you can see which carrier is delivering your shipment. Please note, if you order multiple items, you may have multiple deliveries and multiple carriers.',
            ),
            ItemFAQ(
              title: 'How do I return a Nike order?',
              content:
                  'If you’re a Nike Member, sign in before you start your free return from your orders page. If you’re not a Nike Member, you’ll need to access your order with your order number and email address. You also can head to your nearest Nike store to make a return. For additional details, check out our return instructions.',
            ),
            ItemFAQ(
              title: 'How do I return a Nike store purchase?',
              content:
                  'You can take the items you want to return to any Nike store.',
            ),
            ItemFAQ(
              title:
                  'Can I return items I purchased at a Nike Clearance store?',
              content:
                  'No, items purchased at a Nike Clearance store cannot be returned or exchanged unless they\'re defective or flawed.',
            ),
            ItemFAQ(
              title: 'What about defective or flawed items?',
              content:
                  'We stand behind all of our shoes and gear. If it’s been less than 60 days since your purchase, use one of the options above to return a defective or flawed item. If it’s been more than 60 days, please contact us to return the item. See our warranty information for additional details.',
            ),
            ItemFAQ(
              title: 'Where do I find my estimated delivery date?',
              content:
                  'You’ll see an estimated order delivery date during checkout, on your order status page, and when you track your order. Because this date is an estimate, your order could be delivered shortly before or shortly after this date.',
            ),
            ItemFAQ(
              title: 'Can I change the delivery address on my order?',
              content:
                  'No, our team moves quickly to process and ship your order—we cannot change your order or your delivery address. However, after your order ships, you can contact the carrier directly to see if they can update the address or redirect the package to a pickup facility.',
            ),
            ItemFAQ(
              title: 'Why hasn’t my tracking information updated?',
              content:
                  'Don’t worry if your tracking information doesn’t immediately populate—the carrier sometimes takes up to 48 hours to activate the tracking information. Please check back, the tracking information should update soon.',
            ),
            // ItemFAQ(),
            // ItemFAQ(),
            // ItemFAQ(),
          ],
        ),
      ),
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ";

class ItemFAQ extends StatelessWidget {
  const ItemFAQ({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
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
                  theme: ExpandableThemeData(
                      iconColor: Theme.of(context).iconTheme.color,
                      expandIcon: Icons.arrow_drop_down,
                      collapseIcon: Icons.arrow_drop_down,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      // iconColor: Colors.black,
                      iconPadding: EdgeInsets.only(top: 10, right: 10)),
                  header: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        title,
                        style: const TextStyle(
                            // color: Colors.black,
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
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              content,
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
