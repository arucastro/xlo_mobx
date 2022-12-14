import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  const PriceRangeField({Key? key, required this.filterStore})
      : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Preço'),
          Row(
            children: [
              PriceField(
                  label: 'Min',
                  onChanged: filterStore.setMinPrice,
                  initialValue: filterStore.minPrice),
              const SizedBox(width: 20),
              PriceField(
                  label: 'Max',
                  onChanged: filterStore.setMaxPrice,
                  initialValue: filterStore.maxPrice),
            ],
          ),
          Observer(builder: (_) {
            if (filterStore.priceError != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  filterStore.priceError!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      );
    });
  }
}
