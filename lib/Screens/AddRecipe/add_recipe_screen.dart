// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RecipeStep {
//   String description;

//   RecipeStep(this.description);

//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//     };
//   }
// }

// class RecipeIngredient {
//   String name;
//   String quantity;

//   RecipeIngredient(this.name, this.quantity);

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'quantity': quantity,
//     };
//   }
// }

// class AddRecipeScreen extends StatefulWidget {
//   @override
//   _AddRecipeScreenState createState() => _AddRecipeScreenState();
// }

// class _AddRecipeScreenState extends State<AddRecipeScreen> {
//   String title = '';
//   int servings = 1;
//   List<RecipeIngredient> ingredients = [];
//   List<RecipeStep> steps = [];

//   TextEditingController ingredientNameController = TextEditingController();
//   TextEditingController ingredientQuantityController = TextEditingController();
//   TextEditingController stepController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Recipe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Recipe Title'),
//               onChanged: (value) {
//                 setState(() {
//                   title = value;
//                 });
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Number of Servings'),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 setState(() {
//                   servings = int.tryParse(value) ?? 1;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Text('Ingredients'),
//             _buildIngredientList(),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: ingredientNameController,
//                     decoration: InputDecoration(labelText: 'Ingredient Name'),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: TextFormField(
//                     controller: ingredientQuantityController,
//                     decoration: InputDecoration(labelText: 'Quantity'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       String name = ingredientNameController.text;
//                       String quantity = ingredientQuantityController.text;

//                       if (name.isNotEmpty && quantity.isNotEmpty) {
//                         ingredients.add(RecipeIngredient(name, quantity));
//                         ingredientNameController.clear();
//                         ingredientQuantityController.clear();
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text('Steps'),
//             _buildStepList(),
//             TextFormField(
//               controller: stepController,
//               decoration: InputDecoration(labelText: 'Step'),
//             ),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 setState(() {
//                   String description = stepController.text;
//                   if (description.isNotEmpty) {
//                     steps.add(RecipeStep(description));
//                     stepController.clear();
//                   }
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 submitRecipe(
//                   title,
//                   servings,
//                   ingredients,
//                   steps,
//                 );
//               },
//               child: Text('Submit'),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIngredientList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: ingredients.length,
//       itemBuilder: (context, index) {
//         if (index < ingredients.length) {
//           var ingredient = ingredients[index];
//           return ListTile(
//             title: Text('${ingredient.name} - ${ingredient.quantity}'),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 setState(() {
//                   ingredients.removeAt(index);
//                 });
//               },
//             ),
//           );
//         }
//         return Container(); // Return an empty container for out of bounds index
//       },
//     );
//   }

//   Widget _buildStepList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: steps.length,
//       itemBuilder: (context, index) {
//         if (index < steps.length) {
//           var step = steps[index];
//           return ListTile(
//             title: Text('Step ${index + 1}: ${step.description}'),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 setState(() {
//                   steps.removeAt(index);
//                 });
//               },
//             ),
//           );
//         }
//         return Container(); // Return an empty container for out of bounds index
//       },
//     );
//   }

//   void submitRecipe(
//     String title,
//     int servings,
//     List<RecipeIngredient> ingredients,
//     List<RecipeStep> steps,
//   ) async {
//     final apiUrl =
//         'http://localhost:8000/addrecipe/'; // Replace with your backend API endpoint

//     // Convert RecipeIngredient and RecipeStep to JSON format
//     List<Map<String, dynamic>> ingredientsJson =
//         ingredients.map((e) => e.toJson()).toList();
//     List<Map<String, dynamic>> stepsJson =
//         steps.map((e) => e.toJson()).toList();

//     final Map<String, dynamic> data = {
//       'title': title,
//       'servings': servings,
//       'ingredients': ingredientsJson,
//       'steps': stepsJson,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 200) {
//         print('Recipe data sent successfully!');
//         print('Response: ${response.body}');
//       } else {
//         print('Failed to send recipe data. Error ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
// }

import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

class RecipeStep {
  String description;

  RecipeStep(this.description);

  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }
}

class RecipeIngredient {
  String name;
  String quantity;

  RecipeIngredient(this.name, this.quantity);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}

class RecipeDetailsPage extends StatefulWidget {
  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  String title = '';
  int servings = 1;
  String difficulty = 'easy';
  int selectedHours = 0;
  int selectedMinutes = 0;

  Future<void> _selectDuration(BuildContext context) async {
    int initialHours = selectedHours;
    int initialMinutes = selectedMinutes;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Cook Time'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // // NumberPicker for Hours
              // Expanded(
              //   flex: 2,
              //   child: NumberPicker(
              //     value: selectedHours,
              //     minValue: 0,
              //     maxValue: 24,
              //     onChanged: (value) {
              //       setState(() {
              //         selectedHours = value;
              //       });
              //     },
              //     itemHeight: 50, // Adjust as needed
              //   ),
              // ),
              Text('Hours'),
              // // NumberPicker for Minutes
              // Expanded(
              //   flex: 2,
              //   child: NumberPicker(
              //     value: selectedMinutes,
              //     minValue: 0,
              //     maxValue: 59,
              //     onChanged: (value) {
              //       setState(() {
              //         selectedMinutes = value;
              //       });
              //     },
              //     itemHeight: 50, // Adjust as needed
              //   ),
              // ),
              Text('Minutes'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Restore initial values if cancel is pressed
                setState(() {
                  selectedHours = initialHours;
                  selectedMinutes = initialMinutes;
                });
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              // ... (Recipe Title)
              decoration: InputDecoration(labelText: 'Recipe Title'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              // ... (Number of Servings)
              decoration: InputDecoration(labelText: 'Number of Servings'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  servings = int.tryParse(value) ?? 1;
                });
              },
            ),
            // ... (Difficulty dropdown)
            DropdownButtonFormField<String>(
              value: difficulty,
              onChanged: (newValue) {
                setState(() {
                  difficulty = newValue!;
                });
              },
              items: <String>['easy', 'medium', 'hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Difficulty'),
            ),
            // ... (Cook Time with scrollbar)
            ListTile(
              title: Text('Cook Time'),
              subtitle: Text('$selectedHours hours $selectedMinutes minutes'),
              onTap: () => _selectDuration(context),
            ),
            // ... (Next button)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IngredientsAndStepsPage(
                      title: title,
                      servings: servings,
                      difficulty: difficulty,
                      cookTime: '$selectedHours hours $selectedMinutes minutes',
                    ),
                  ),
                );
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}

class IngredientsAndStepsPage extends StatefulWidget {
  final String title;
  final int servings;
  final String difficulty;
  final String cookTime;

  IngredientsAndStepsPage({
    required this.title,
    required this.servings,
    required this.difficulty,
    required this.cookTime,
  });

  @override
  _IngredientsAndStepsPageState createState() =>
      _IngredientsAndStepsPageState();
}

class _IngredientsAndStepsPageState extends State<IngredientsAndStepsPage> {
  List<RecipeIngredient> ingredients = [];
  List<RecipeStep> steps = [];

  TextEditingController ingredientNameController = TextEditingController();
  TextEditingController ingredientQuantityController = TextEditingController();
  TextEditingController stepController = TextEditingController();

  // Other properties and controllers...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingredients and Steps'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text('Ingredients'),
            _buildIngredientList(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ingredientNameController,
                    decoration: InputDecoration(labelText: 'Ingredient Name'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: ingredientQuantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      String name = ingredientNameController.text;
                      String quantity = ingredientQuantityController.text;

                      if (name.isNotEmpty && quantity.isNotEmpty) {
                        ingredients.add(RecipeIngredient(name, quantity));
                        ingredientNameController.clear();
                        ingredientQuantityController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Steps'),
            _buildStepList(),
            TextFormField(
              controller: stepController,
              decoration: InputDecoration(labelText: 'Step'),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  String description = stepController.text;
                  if (description.isNotEmpty) {
                    steps.add(RecipeStep(description));
                    stepController.clear();
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                submitRecipe(
                  widget.title,
                  widget.servings,
                  widget.difficulty,
                  widget.cookTime,
                  ingredients,
                  steps,
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        if (index < ingredients.length) {
          var ingredient = ingredients[index];
          return ListTile(
            title: Text('${ingredient.name} - ${ingredient.quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  ingredients.removeAt(index);
                });
              },
            ),
          );
        }
        return Container(); // Return an empty container for out of bounds index
      },
    );
  }

  Widget _buildStepList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        if (index < steps.length) {
          var step = steps[index];
          return ListTile(
            title: Text('Step ${index + 1}: ${step.description}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  steps.removeAt(index);
                });
              },
            ),
          );
        }
        return Container(); // Return an empty container for out of bounds index
      },
    );
  }

  void submitRecipe(
    String title,
    int servings,
    String difficulty,
    String cookTime,
    List<RecipeIngredient> ingredients,
    List<RecipeStep> steps,
  ) {
    // TODO: Implement submitting the recipe to the backend
    // You can use the provided data to send the recipe to your backend
    // Use the 'http' package to make a POST request to your backend API
  }
}
