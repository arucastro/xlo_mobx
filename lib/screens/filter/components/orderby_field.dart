import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';

import '../../../stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  const OrderByField({Key? key, required this.filterStore}) : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: (){
          filterStore.setOrderBy(option);
        },
        child: Container(
          width: 80,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: filterStore.orderBy == option ? Colors.black : Colors.grey, width: 2),
            color: filterStore.orderBy == option
                ? Colors.purple
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  filterStore.orderBy == option ? Colors.white : Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Ordenar por'),
        Observer(builder: (_){
          return Row(
            children: [
              buildOption('Data', OrderBy.DATE),
              const SizedBox(width: 20),
              buildOption('Preço', OrderBy.PRICE),
            ],
          );
        })
      ],
    );
  }
}
