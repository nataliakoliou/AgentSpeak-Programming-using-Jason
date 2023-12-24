## Task-1: Expand Flight Reservations
The manager currently holds two flight reservations from a passenger. Three new passengers have requested these flight reservations: Paris to Istanbul, Boston to Rome, and Seville to Beijing. Add these additional requests to the manager's goal base.

<sup>🗝TIP: Modify the manager's initial goals within [manager.asl]() file to include the new flight requests.</sup>

## Task-2: Update Price Ranges
Adjust the price range to [100,180] for Aegean, [100,200] for Aeroflot and [120,170] for Lufthansa aircrafts.

<sup>🗝TIP: Locate the price definition within each aircraft's .asl file. If it's not already defined, create a definition yourself. Adjust the belief that generates random prices: price(_Service, X) :- .random(R) & X = (R * Range) + LowerBound, to match the specified price ranges.</sup>

## Task-3: Refactor Task Representation
The current implementation represents flight requests as strings: e.g., "flight(athens,berlin)". Modify the system to recognize flight requests as literals: flight(Source, Destination) instead.

<sup>🗝TIP: Replace variable Task with predicate flight(Source, Destination) in all .asl files wherever the Task variable appears.</sup>

## Task-4: Make Aeroflot Functional with Flight Limitations
Aeroflot, which was previously fully booked for all its scheduled flights, is now open to new passenger requests. However, due to its current flight program limitations, the airline is unable to accommodate flights to/from Paris.

<sup>🗝TIP: You can use the [aegean.asl]() as a template for [aeroflot.asl]() since Aegean aircrafts are currently the only functional ones in our scenario. Create a rule to define when a flight is considered forbidden for an Aeroflot aircraft (Paris either as source or destination). When this condition holds, the aircraft shall reject incoming requests.</sup>

## Task-5: Make Lufthansa Functional with Varying Pricing Policies
Lufthansa, which was previously under maintainance, is now open to new passenger requests. To become competitive, the company decided to provide a 50% discount for flights to Rome.

<sup>🗝TIP: You can use the [aegean.asl]() as a template for [lufthansa.asl](). Turn the current pricing policy into a conditional one, to offer a discount for requests of type: flight(_,rome).</sup>
