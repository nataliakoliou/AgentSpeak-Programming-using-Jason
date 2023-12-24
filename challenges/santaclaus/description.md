## Task-1: Modify Santa's Resuming Priority
Currently, when Santa resumes a group of agents, reindeers have priority over elves. Adjust the priority sequence so that when Santa resumes agent groups, elves are given priority over reindeers.

<sup>🗝TIP: Modify the resume_all plan within the [santa.asl]() file.</sup>

## Task-2: Implement Santa's Break Time
Allow Santa to take a 100-milliseconds break, as soon as he completes 10 rounds of work. After the break, Santa should again start working with some group of agents.

<sup>🗝TIP: Expand the work plan within the [santa.asl]() file.</sup>

## Task-3: Apply Auction Mechanism for Resumed Groups
Introduce an auction mechanism for the groups of agents, to determine the order in which they will be resumed. Each group informs Santa about the total cost of their work, which is calculated by summing up the cost values of each member in the group. Santa selects to resume the group with the lowest total cost value.

<sup>🗝TIP: In the [worker.asl]() file, define a rule for an offer(O) where O is a number within the range [0,10], representing the offer of an agent (either elf or reindeer). Include O as an argument in the iamhere predicate, as well as the group predicate. Create a counter predicate offers() in the [secretary.asl]() to sum the offers. In [santa.asl](), expand the resume_all plan using the internal actions .findall() and .min(), to facilitate Santa's selection of the group with the lowest total cost value.</sup>

## Task-4: Set Distinct Minimum Cost in Group Offers
Modify the offer rule introduced in the previous task: Offer = (R * Range) + LowerBound. Set a distinct lower bound for each kind of group: a minimum cost of 1 for elves and a minimum cost of 5 for reindeers.

<sup>🗝TIP: Add a distinct belief predicate mincost() for elves and reindeers within the [santaclaus.mas2j]() file - similar to the kind() belief. Adjust the offer rule in the [worker.asl]() file to include this minimum cost value.</sup>

## Task-5: Make Secretary Biased towards Specific Elves
Make Edna, the secretary for the elves, biased towards elf2 and elf7. Whenever she receives a request from these elves to either form or join a group, she increases their offer by adding an extra charge of +100. This increase affects their group's overall cost, in a way that will eventually discourage Santa to help them soon, in case they get resumed.

<sup>🗝TIP: Define charge plan and extra() belief in the [secretary.asl]() file. This extra() belief should assign either 0 or 100 depending on the elf. Modify the secretary's response to forming groups and sending offers to Santa, incorporating this additional charge value for elf2 and elf7.</sup>
