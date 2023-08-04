import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class Categories {
  List<String> categories = [
    "Drinks",
    "Veg",
    "Non-Vag",
    "Rice",
    "Snacks",
    "Salads",
    "Desserts",
  ];

  List<String> selectedCategory = [];
  Widget generateTags() {
    return selectedCategory.isEmpty
        ? Container()
        : Container(
            alignment: Alignment.topLeft,
            child: Tags(
              alignment: WrapAlignment.center,
              itemCount: selectedCategory.length,
              itemBuilder: (index) {
                return ItemTags(
                  index: index,
                  title: selectedCategory[index],
                  color: Colors.blue,
                  activeColor: Colors.red,
                  onPressed: (Item item) {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  elevation: 0.0,
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  textColor: Colors.white,
                  textActiveColor: Colors.white,
                  removeButton: ItemTagsRemoveButton(
                    onRemoved: () {
                      selectedCategory.removeAt(index);
                      return true;
                    },
                  ),
                  textOverflow: TextOverflow.ellipsis,
                );
              },
            ),
          );
  }
}
