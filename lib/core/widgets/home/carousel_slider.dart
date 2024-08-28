import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/core/models/carousel_models.dart';
import 'package:food_app/core/components/loading.dart';

class CarouselWidget extends StatelessWidget {
  final List<Carousel> carousels;

  const CarouselWidget({super.key, required this.carousels});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
      items: carousels.map((carousel) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  "http://10.0.2.2:8000/storage/${carousel.imagePath}",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: CustomLoading(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CustomLoading(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
