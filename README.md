# Database assigment 2


## Tasks given
Create a new HBase table called foods with a single column family to store the facts.
- What can be used for the row key?
  - The unique identifier Food_Code we have chosen to use as our row key
- What column family options make sense for this data?
  - We have chosen 3 families.
  - "Text" which contains the name of the food
  - "portions" which contains details of the portions sizes
  - "ingredients" which contains the ingredients in the food type
  - "nutrient" which contains the nutrients of the food type
   


#### Create code for importing the food data into the new table.

Script "HbaseFoodScript.rb" submitted in this repo
<br>
Command to run the script
<br>
```
cat $FOOD_LOC/Food_Display_Table.xml | $HBASE_HOME/hbase-2.2.3/bin/hbase shell $SCRIPT_FILE_LOC/insertfood.rb
```
Using the HBase shell, query the foods table for information about your favourite foods.

```
hbase(main):011:0> get 'foods','58130010'
``` 

|COLUMN                            |  CELL
| ------------- | ------------- |
|ingredients:Drkgreen_Vegetables   | timestamp=1585844511077, value=.00000|
ingredients:Drybeans_Peas          | timestamp=1585844511077, value=.00000
ingredients:Fruits                 | timestamp=1585844511077, value=.00000
ingredients:Meats                  | timestamp=1585844511077, value=.83750
ingredients:Milk                   | timestamp=1585844511077, value=.85500
ingredients:Oils                   | timestamp=1585844511077, value=.00000
ingredients:Orange_Vegetables      | timestamp=1585844511077, value=.00000
ingredients:Other_Vegetables       | timestamp=1585844511077, value=.41250
ingredients:Soy                    | timestamp=1585844511077, value=.00000
ingredients:Starchy_vegetables     | timestamp=1585844511077, value=.00000
ingredients:Vegetables             | timestamp=1585844511077, value=.41500
ingredients:Whole_Grains           | timestamp=1585844511077, value=.00000
nutrient:Added_Sugars              | timestamp=1585844511077, value=8.33018
nutrient:Alcohol                   | timestamp=1585844511077, value=.00000
nutrient:Calories                  | timestamp=1585844511077, value=390.00000
nutrient:Saturated_Fats            | timestamp=1585844511077, value=7.65000
nutrient:Solid_Fats                | timestamp=1585844511077, value=103.65750
portions:Amount                    | timestamp=1585844511077, value=1.00000
portions:Default                   | timestamp=1585844511077, value=2.00000
portions:Display_Name              | timestamp=1585844511077, value=cup
portions:Factor                    | timestamp=1585844511077, value=1.00000
portions:Increment                 | timestamp=1585844511077, value=.50000
portions:Multiplier                | timestamp=1585844511077, value=.50000
text:                              | timestamp=1585844511077, value=Meat lasagna

1 row(s)
<br>
Took 0.0926 seconds
<br>
Meat lasagna :)
