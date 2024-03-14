import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/country.dart';

// FlagImage Widget represents an image displaying the flag of a country.
class FlagImage extends StatelessWidget {
  final CountryEntity country;
  final double width;

  const FlagImage({
    super.key,
    required this.country,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(width / 2),
      child: Tooltip(
        message: country.name,
        child: Ink(
          width: width,
          height: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width /
                2), // Applying border radius to the flag image (important so it shows a circle and not an oval).
            color: Colors.transparent,
          ),
          child: SvgPicture.network(
            country.flag!,
            width: width,
            height: width,
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
            placeholderBuilder: (BuildContext context) =>
                const CircularProgressIndicator(), // Placeholder while loading
          ),
        ),
      ),
    );
  }
}
