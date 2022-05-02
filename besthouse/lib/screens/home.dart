import 'package:flutter/material.dart';

//model
import '../models/house.dart';
import '../models/location.dart';

//widget
import '../widgets/home/house_card.dart';

//screen
import '../screens/google_location.dart';
import '../screens/house_detailed.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.onTapHandler}) : super(key: key);
  static const routeName = "/home";
  final Function onTapHandler;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  final controller1 = PageController(initialPage: 1);
  final List<House> housesFeature = [
    House(
      id: "634gf3438",
      name: "Cosmo Home",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 4000,
      location: Location(
        coordinates: [-6.2108, 106.8451],
      ),
      address: 'Soi 45 Prachauthid Thungkru, Bangkok',
      type: 'CONDOMINIUM',
    ),
    House(
      id: "634gf3438",
      name: "Heliconia House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
    House(
      id: "634gf3438",
      name: "Heliconia House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
    House(
      id: "634gf3438",
      name: "Heliconia House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
    House(
      id: "634gf3438",
      name: "Heliconia House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
  ];

  final List<House> housesRec = [
    House(
      id: "634gf3438",
      name: "Spy Home",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 4000,
      location: Location(
        coordinates: [-6.2108, 106.8451],
      ),
      address: 'Soi 45 Prachauthid Thungkru, Bangkok',
      type: 'CONDOMINIUM',
    ),
    House(
      id: "634gf3438",
      name: "Willy House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
    House(
      id: "634gf3438",
      name: "Jannie House",
      pictureUrl:
          "https://images.theconversation.com/files/377569/original/file-20210107-17-q20ja9.jpg?ixlib=rb-1.1.0&rect=108%2C502%2C5038%2C2519&q=45&auto=format&w=1356&h=668&fit=crop",
      price: 6000,
      location: Location(
        coordinates: [13.2108, 107.8451],
      ),
      address: 'KMUTT university Prachauthid Thungkru, Bangkok',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Where ?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, GoogleLocation.routeName)
                        .then((value) => {widget.onTapHandler()});
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: _searchController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: "Search your desire location!",
                      fillColor: Color(0xFFE9E9E9),
                      filled: true,
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/house_image.png",
              scale: 1.2,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Featured House',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            housesFeature.isNotEmpty
                ? SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: housesFeature.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HouseCard(
                          house: housesFeature[index],
                          showInfoHandler: _showInfo,
                        );
                      },
                    ),
                  )
                : const Text('No houses found'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Discover around you',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.left,
              ),
            ),
            housesRec.isNotEmpty
                ? SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: housesRec.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HouseCard(
                          house: housesRec[index],
                          showInfoHandler: _showInfo,
                        );
                      },
                    ),
                  )
                : const Text('No houses found'),
          ],
        ),
      ),
    );
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }
}
