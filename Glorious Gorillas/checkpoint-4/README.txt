Hello, thanks for reading :)

1. For the both questions, we developed the nodes and links through sql (please see the CP4GG.sql file in src for more explanations), converted to json and made them into graphs via d3.
Our first question is:
Look to uncover the most accused demographic group per officer as compared with the second most accused demographic group, proportionally. Understand if one group is accused more often than others. Nodes of the graphs would be the accused groups and the edges will be the relationship between the first and x most targeted demographic groups.

To run this code, the respective json files are in the "data" folder. Simply go to the d3 file for this question, and on the data loading line of code, upload the respective json file. The rest of the code should run on its own past that.
When you get the results, you can play with the nodes in the graph and see the associations between officers and the complaints from their most frequent demographic group. The colors refer to each group/race, which you can refer to through the json file.

2. Look for trends as a generalization of officer complaints over time. Compare progression of complaints over time between officers to understand any relationships of Time v Accusations.
The process to run this is the exact same as question 1.
