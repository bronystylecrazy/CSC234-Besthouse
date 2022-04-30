import 'package:flutter/material.dart';

//model
import 'package:besthouse/models/house.dart';
import '../screens/house_detailed.dart';

//widget
import '../widgets/common/house_detail_card.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);
  static const routeName = "/favourite";

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final List<House> houses = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Favorite",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.thumb_up,
                  color: Color.fromRGBO(84, 156, 169, 100),
                  size: 30,
                ),
              ],
            ),
            houses.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: houses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HouseDetailCard(
                          house: houses[index],
                          showInfoHandler: _showInfo,
                        );
                      },
                    ),
                  )
                : const Text('No houses found'),
          ],
        ),
        // Container(
        //   child: ListView.builder(
        //     itemCount: houses.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Colors.white,
        //           ),
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Row(
        //               children: [
        //                 Container(
        //                   height: 100,
        //                   width: 100,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                     image: DecorationImage(
        //                       image: NetworkImage(houses[index].pictureUrl),
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   width: 10,
        //                 ),
        //                 Expanded(
        //                   child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           houses[index].name,
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 18,
        //                             fontWeight: FontWeight.bold,
        //                             color: Color.fromARGB(255, 5, 5, 5),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 10,
        //                         ),
        //                         Text(
        //                           houses[index].address,
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 14,
        //                             fontWeight: FontWeight.bold,
        //                             color: Color.fromARGB(255, 5, 5, 5),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           height: 10,
        //                         ),
        //                         Text(
        //                           "Price: ${houses[index].price}",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 14,
        //                             fontWeight: FontWeight.bold,
        //                             color: Color.fromARGB(255, 5, 5, 5),
        //                           ),
        //                         ),
        //                       ]),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }

  void _showInfo(String id) {
    Navigator.of(context).pushNamed(HouseDetailed.routeName, arguments: {
      'id': id,
    });
  }
}
