import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import '../models/state.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';
  Widget _buildSwitchListTile(
    BuildContext context,
    String title,
    String description,
    String valueName,
  ) {
    var state = Provider.of<appState>(context, listen: true);
    return SwitchListTile(
      title: Text(title),
      value: state.filter.contains(valueName) ? true : false,
      subtitle: Text(
        description,
      ),
      onChanged: (value) {
        state.filter.contains(valueName)
            ? state.removeFilter(valueName)
            : state.addFilter(valueName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(context, 'Gluten-free',
                    'Only include gluten-free meals.', 'gluten-free'),
                _buildSwitchListTile(context, 'Diary-free',
                    'Only include dairy-free meals.', 'dairy-free'),
                _buildSwitchListTile(context, 'Vegetarian',
                    'Only include vegetarian meals.', 'vegetarian'),
                _buildSwitchListTile(
                  context,
                  'Vegan',
                  'Only include vegan meals.',
                  'vegan',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
