import 'dart:convert';

import 'package:flutter/material.dart';
import 'cook_time_input.dart';
import 'package:http/http.dart' as http;

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
  final String userId;

  RecipeDetailsPage({required this.userId});

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  String title = '';
  int servings = 1;
  String difficulty = 'easy';
  int selectedHours = 0;
  int selectedMinutes = 0;

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CookTimeInput(
                initialHours: selectedHours,
                initialMinutes: selectedMinutes,
                onHoursChanged: (hours) {
                  setState(() {
                    selectedHours = hours;
                  });
                },
                onMinutesChanged: (minutes) {
                  setState(() {
                    selectedMinutes = minutes;
                  });
                },
              ),
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
                      userId: widget.userId,
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
  final String userId;

  IngredientsAndStepsPage({
    required this.title,
    required this.servings,
    required this.difficulty,
    required this.cookTime,
    required this.userId,
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
                  widget.userId,
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
    String userId,
    String title,
    int servings,
    String difficulty,
    String cookTime,
    List<RecipeIngredient> ingredients,
    List<RecipeStep> steps,
  ) async {
    final apiUrl = 'http://localhost:8000/addrecipe/';

    final Map<String, dynamic> recipeData = {
      "userId": userId,
      "title": title,
      "servings": servings,
      "difficulty": difficulty,
      "cookTime": cookTime,
      "ingredients":
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      "steps": steps.map((step) => step.toJson()).toList(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(recipeData),
      );

      if (response.statusCode == 200) {
        // Recipe added successfully
        print('Recipe added successfully');
      } else {
        // Error adding recipe
        print('Error adding recipe. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Exception occurred
      print('Exception: $error');
    }
  }
}
