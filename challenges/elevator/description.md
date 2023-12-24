## Task-1: Define Bob's Preferences
Bob reads a note on the wall that says: "Pressing the button only works when the elevator is on floor 0,1 or 2. Please wait until then!". Your goal is to make Bob's button unresponsive when the elevator's floor is higher than the third.

<sup>🗝TIP: You can define this floor restriction as a preference within Bob's plans. Agent preferences are defined in the "context" of a plan!</sup>


## Task-2: Change the Elevator's Starting Point
The elevator currently starts on the ground floor. Change its initial state so that it begins on the fifth floor instead.

<sup>🗝TIP: Modify the [elevator.mas2j]() configuration file.</sup>


## Task-3: Implement a Plan Failure Response
Modify Bob's behavior to trigger a plan failure event for the "+!served" goal. You should introduce a print event with the message "I'll wait here." and ensure that Bob waits without taking any action until the elevator's state fits Bob's preferences (reaches a floor not higher than the third).

<sup>🗝TIP: Your objective is to have Bob repeatedly state "I'll wait here." until he gets "served".</sup>


## Task-4: Introduce Alice the Helper-Agent
Bob's button is unresponsive when the elevator is on floors higher than the third. To help him reach his destination, you will introduce a new character in the project, named Alice. Alice needs to use the elevator to travel from the third floor to the second floor. Bob will ask her to call the elevator and get "served". Alice's job is to make the elevator move to the second floor, allowing Bob to call it from there, where the button is responsive.

<sup> **🗝TIP:** To bring Alice into the scenario, you'll need to create a new ASL file for her and modify the [elevator.mas2j]() configuration file. To facilitate her collaboration with Bob, adjust Bob's plans.</sup>


## Task-5: Introduce Paul the Impatient Traveler
You will introduce another character in the project, named Paul. He needs to use the elevator to travel from the seventh floor to the sixth floor. However, Paul is in a hurry and will only wait for the elevator if it's no more than one floor away from his own. Otherwise, he'll opt for the stairs.

<sup> **🗝TIP:** Create a new ASL file for Paul and modify the [elevator.mas2j]() configuration file. Add Paul's preferences, just like you did with Bob. Also note that "taking the stairs" is considered an action! You will need "act.getFunctor().equals("...")" to extend the agents' set of action.</sup>


## Task-6: Change the Elevator's Starting Point
The elevator currently starts on the fifth floor. Change its initial state so that the it begins on the sixth floor instead.

<sup>🗝TIP: Modify the [elevator.mas2j]() configuration file.</sup>
