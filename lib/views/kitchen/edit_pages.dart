import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geteat/views/kitchen/edit_meal_list_page.dart';
import 'package:geteat/views/kitchen/edit_restaurant_list_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return TwoPane(
      startPane: EditRestaurantListPage(),
      endPane: EditMealListPage(),
      paneProportion: 0.4,
    );
  }
}
