import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import 'components/orderby_field.dart';
import 'components/price_range_field.dart';
import 'components/vendor_type_field.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrderByField(filterStore: filterStore),
                    PriceRangeField(filterStore: filterStore),
                    VendorTypeField(filterStore: filterStore),
                    Observer(builder: (_){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            backgroundColor: Colors.orange,
                            disabledBackgroundColor: Colors.orangeAccent,
                          ),
                          onPressed: filterStore.isFormValid ? (){
                            filterStore.save();
                            Navigator.of(context).pop();
                          } : null,
                          child: const Text(
                            'Filtrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
