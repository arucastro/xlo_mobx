import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';

import '../../../stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  const VendorTypeField({Key? key, required this.filterStore})
      : super(key: key);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: 'Tipo de anunciante'),
        Observer(builder: (_){
          return Wrap(
            runSpacing: 4,
            children: [
              GestureDetector(
                onTap: (){
                  if (filterStore.isTypeParticular){
                    if(filterStore.isTypeProfessional){
                      filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                    }else{
                      filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  }else{
                    filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: filterStore.isTypeParticular ? Colors.black : Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(25),
                    color: filterStore.isTypeParticular ? Colors.purple : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Particular',
                    style: TextStyle(
                      color: filterStore.isTypeParticular ? Colors.white : Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: (){
                  if (filterStore.isTypeProfessional){
                    if(filterStore.isTypeParticular){
                      filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }else{
                      filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  }else{
                    filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: filterStore.isTypeProfessional ? Colors.black : Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(25),
                    color: filterStore.isTypeProfessional ? Colors.purple : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Profissional',
                    style: TextStyle(
                      color: filterStore.isTypeProfessional ? Colors.white : Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          );
        })
      ],
    );
  }
}
