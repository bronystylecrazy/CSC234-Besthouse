import 'package:besthouse/models/house.dart';
import 'package:besthouse/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final Function showInfoHandler;

  const HouseCard({
    Key? key,
    required this.house,
    required this.showInfoHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(14);
    final TextStyle detailStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    );

    return InkWell(
      onTap: () => showInfoHandler(house.id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: Image.network(
                Constants.baseUrl + house.pictureUrl,
                fit: BoxFit.cover,
                height: 150,
                width: 300,
                errorBuilder: (context, error, stackTrace) => Image.network(
                  'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640',
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                        child: Text(
                          house.name,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => showInfoHandler(house.id),
                        child: Row(
                          children: [
                            Text(
                              'more info',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 233, 250, 252),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 233, 250, 252),
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              house.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: detailStyle,
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              'price: ${house.price} ฿',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: detailStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
