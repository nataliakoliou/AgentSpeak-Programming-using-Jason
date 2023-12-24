## Task-1: Add two additional Garbage Items
The grid currently holds five garbage items. You are asked to include two more items at some given locations on the grid. The first location is two blocks to the left of the center block within the grid. The second one is located at coordinates (2, 1).

<sup>🗝TIP: In the Env.java file, look for the section that manages the initial placement of garbage items.</sup>


## Task-2: Make the Agent Search the Grid Iteratively
Modify the agent's behavior to continuously search the grid. Once it reaches the last location (bottom-right), make it restart the search algorithm from the top-right of the grid.

<sup>🗝TIP: Find the nextSlot() method and adjust the condition that triggers when the agent reaches the end of the grid.</sup>


## Task-3: Implement Dynamic Garbage Generation
Remove all initial garbage locations and introduce a dynamic system for garbage generation. Garbage should appear randomly within the grid at certain intervals. Use the condition random.nextInt(200) < 10 to control the frequency of garbage appearance.

<sup>🗝TIP: Create the generateRandomGarbage() method within the MarsModel class. Use [getWidth()](https://jason-lang.github.io/api/jason/environment/grid/GridWorldModel.html#getWidth()) and [getHeight()](https://jason-lang.github.io/api/jason/environment/grid/GridWorldModel.html#getHeight()) from the GridWorldModel class. Implement an if-condition inside the executeAction method to manage garbage generation based on the specified frequency.</sup>


## Task-4: Modify the Garbage Generation Frequency
Change the frequency of garbage generation by adjusting the if condition. Generate garbage randomly only when a boolean condition is true and the number of garbages on the grid is less than or equal to 3.

<sup>🗝TIP: Use the [countObjects()](https://jason-lang.github.io/api/jason/environment/grid/GridWorldModel.html#countObjects(int)) method from the GridWorldModel class to limit the number of garbages on the grid.</sup>
