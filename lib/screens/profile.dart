import 'package:flutter/material.dart';
import 'package:flutter_foodybite/util/widgets.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({this.profileId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // We need to check if this user is already in my network
    final String currentUserId = '2';

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Expanded(flex: 2, child: _TopPortion()),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          "Richie Lorie",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:300,
                            child:FloatingActionButton.extended(
                              onPressed: () {},
                              heroTag: 'invite',
                              elevation: 0,
                              label: const Text("Invite to see social links"),
                              icon: const Icon(Icons.person_add_alt_1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const _ProfileInfoRow(),
                      const SizedBox(height: 24),
                      const _ProfileBio(),
                      const SizedBox(height: 24),
                      const _IntrestsBio(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntrestsBio extends StatelessWidget {
  const _IntrestsBio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Padding(
        padding: const EdgeInsets.only(left: 26, right: 26),
        child: Column(
          children: [
            Text(
              "Interests:",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: [
                createTagCard('Cooking'),
                createTagCard('Programming'),
                createTagCard('Yoga'),
                createTagCard('Storytelling'),
                createTagCard('Walking tours'),
                createTagCard('Foodie'),
              ],
            )
          ],
        ),
    ));
  }
}

class _ProfileBio extends StatelessWidget {
  const _ProfileBio({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26),
        child: Column(
          children: [
            Text(
              "Bio:",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Rodney Erickson is a content marketing professional at HubSpot,"
                  " a CRM platform that helps companies attract visitors, convert leads,"
                  " and close customers. Previously, Rodney worked as a marketing"
                  " manager for a tech software startup. ",
              // style: Theme.of(context)
              //     .textTheme
              //     .headline6
              //     ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Best described as:", "Software developer"),
    ProfileInfoItem("Lives in:", "Alcantara"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                item.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final String value;

  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
