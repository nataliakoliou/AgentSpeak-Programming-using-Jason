# Frequently Asked Questions

Have questions about the course or content? You're in the right place. Check out our Q&A section below, where you can find answers to common student questions.

## 🏛 Our Students Q&A Corner

### Question-1: How can I create multiple instances of the same agent?
To create k instances of an agent in Jason, use this structure: #k, where k could be any number e.g. #2, #3, etc. Adjust k to determine the number of instances desired:
```mas2j
MAS taxi_world {
    ...
    agents: taxi #k;   // creates k instances of agent: taxi.asl
    ...
}
```

### Question-2: How can I create multiple instances of an agent with distinct initial beliefs?
Design your agent's logical reasoning in a single ASL file (e.g., agent.asl). Suppose this reasoning includes beliefs like source(X) and destination(Y). You can create multiple instances (e.g., mary, john, george) with distinct initial beliefs as follows:
```mas2j
MAS taxi_management {
    environment: example.Env
    agents:
        mary agent.asl [beliefs="source(2), destination(5)"];
        john agent.asl [beliefs="source(3), destination(0)"];
        george agent.asl [beliefs="source(5), destination(1)"];
    aslSourcePath: "src/agt";
}
```
<sup> 🔎 Check out the **st-claus** example in `jason-bin-3.2.0\examples\st-claus` directory, to see an actual implementation of this scenario.</sup>

### Question-3: How can I track an agent's position?
Define the predicate at(P,A) where A represents the agent and P its position (e.g., floor, grid location) on the environment. To update an agent's position, modify the executeAction(String ag, Structure act) function in the Env.java file as follows:
```java
int posID = 1;  // represents the change in position due to action move(X,Y), where Y signifies the destination at index 1

String position = act.getTerm(posID).toString();
Literal at_pos_ag = Literal.parseLiteral("at(" + position + "," + ag + ")");

addPercept(at_pos_ag);
```

### Question-4: Whose position does the at(P) predicate represent in the elevator example?
Predicate at(P) denotes the floor where the machine (machine.asl) is located, rather than the position of the elevator's users (bob.asl, alice.asl, or paul.asl). In this particular implementation, we can achieve the desired objectives without explicitly marking the user's positions.

In a more complex system, however, specifying these positions might be necessary:
```asl
// using compound predicates (agent/time-sepcific) like these:
at(P,A)
at(P,A,T)
...
```

### Question-5: How can a user call the machine using the at(P,A) predicate in the elevator project?
Suppose bob is our user-agent, that wants to call the machine-agent. Within the 'bob.asl' file, set up a plan structured like this:
```asl
triggering event: at(P,bob) & not served ← .send(machine,achieve,at(P,machine)).
```
Once this plan exists in Bob's architecture, Bob will call the machine whenever this context is satisfied (i.e., every time Bob is somewhere and hasn't been served yet).

### Question-6: How can I use a method from a class of a Jason package in my own class Env?
Suppose you want to use the [canSleep()](https://jason-lang.github.io/api/jason/architecture/AgArch.html#canSleep()) method, implemented in the AgArch class of the jason.architecture package. To call it within your Env class (Env.java), you need to create an instance of the AgArch class:
```java
import jason.architecture.AgArch;

public class Env extends Environment {

    private AgArch agar;  // initializes a class variable 'agar'

    @Override
    public void init(String[] args) {
        agar = new AgArch();  // creates an instance and assigns it to 'agar'
        boolean sleep = agar.canSleep();
        ...
    }
}
```

### Question-7: How can I track and log actions in Jason?
To enable logging of agents' actions within your JASON environment, use [java.util.logging](https://docs.oracle.com/javase/8/docs/api/java/util/logging/Logger.html) package in your Env class. This logging mechanism allows you to monitor actions taken at each timestep, through the JASON console.
```java
import java.util.logging.Logger;

public class Env extends Environment {

      static Logger logger = Logger.getLogger(Env.class.getName());
      ...
      public boolean executeAction(String ag, Structure action) {
            logger.info(ag+" doing: "+ action);
            ...
      }
}
```

### Question-8: How can I store the data of an object within some grid environment?
To keep track of objects' data in a grid environment, set up a list of maps in the Env class. Every time an object changes the grid (e.g. add/move/remove object), this list gets updated. Additionally, you may need to update the list in cases, where objects interact with agents. For example, in the taxi-world application, each entry in the list represents some customer's data, such as its ID, source and destination locations, as well as boolean variables indicating whether the customer has been served or is currently being served, etc:
```java
public class Env extends Environment {
    ...

    class TaxiWorld extends GridWorldModel {
        public List<Map<String, Object>> customerData = new ArrayList<>();  // List to hold maps containing customer details
        ...

        void addCustomer() {
            Location src = getSource();
            Location dst = getDestination();

            add(CUSTOMER, src.x, src.y);  // Add the customer to the grid

            Map<String, Object> details = new HashMap<>();  // Create a new map to store the customer's details
            details.put("id", generateID());
            details.put("source", src);
            details.put("destination", dst);
            details.put("served", false);
            ...

            customerData.add(details);  // Add the customer's details map to the list
            ...
        }
    }
}

```

### Question-9: Where can I find additional resources and materials about Jason?
Here are several valuable links: [Official Website](https://jason-lang.github.io/), [API Documentation](https://jason-lang.github.io/api/), [Related Paper](https://www.researchgate.net/publication/226708984_BDI_agent_programming_in_AgentSpeak_using_Jason), [Official GitHub](https://github.com/jason-lang/jason) and [Lab Slides](https://github.com/nataliakoliou/AgentSpeak-Programming-using-Jason/blob/main/slides.pdf) (check referenced papers as well). Due to the limited resources available for Jason, conducting smart searches on GitHub to find repositories that use it, can be a good practice (e.g. [here](https://github.com/search?q=.mas2j&type=code)).

### Question-10: Is it possible to use .findall to iterate through a list?
The internal action [.findall](https://jason-lang.github.io/api/jason/stdlib/findall.html) in Jason is used for creating lists rather than accessing their individual elements. In Jason, lists serve the purpose of extracting elements that meet specific conditions such as minimum or maximum values.
```asl
+!get_min(L,Min) : .findall(element(V),value(V),L)
   <- .print("Elements in list: ",L);
      .min(L,element(Min));
      .print("Minimum value: ",Min).
```
To navigate through a list in Jason, you need recursion! Recursion triggers the plan iteratively, allowing you to access the elements of the list one by one. Let us represent a list L with a head and a tail: L = (H|T). The head refers to the first element of the list, while the tail refers to the rest of the elements in the list:
```asl
+!triggering_event([], ...).
+!triggering_event([H|T], ...) : context
    <- action(H);
       ... ;
       !triggering_event(T, ...).
```

### Question-11: How can I represent an object with multiple features?
To represent an object with multiple features in Jason, create a predicate with distinct values for each feature. For instance, in the taxi-world application, a client can be represented as a predicate with attributes such as its id, source and destination coordinates, initiator's id and taxi's id, service status, etc. Each time a new client enters the environment, such a predicate is added to the belief base of all agents:
```asl
client(ClientID, SrcX, SrcY, DstX, DstY, InitID = none, TaxiID = none, Served = false, ...).
```

### Question-12: What is the correct way to define static literals in Java?
When defining static literals in Java, it's important to ensure distinct values for each predicate. Consider the example below, which violates this principle by using a variable P within the literal:
```java
public static final Literal pos = Literal.parseLiteral("position(P)");
```
In Java, literals correspond to predicates present in .asl files. For instance, if the .asl file of an agent contains the predicates position(src) and position(dst), you should define two distinct static literals in Java, one for each instance of 'position':
```java
public static final Literal src = Literal.parseLiteral("position(src)");
public static final Literal dst = Literal.parseLiteral("position(dst)");
```

### Question-13: How can I implement automatic agent reset when some condition is satisfied?
To enable agent reset based on a condition, you'll need to create a plan within the agent's .asl file that triggers when a belief representing this condition is added to the agent's belief base. The body of this plan, will clear all the desires and intentions of the agent and prompts him to initiate its activity in the environment once again.
```asl
+condition : true <- .drop_all_desires; .drop_all_intentions; !start.
```

### Question-14: Can I register an agent as both participant and initiator when implementing CNP?
Yes, you can have agents act as both participants and initiators within the Contract Net Protocol. However, using [.df_register](https://jason-lang.github.io/api/jason/stdlib/df_register.html) to achieve this isn't possible and leads to an error:
```asl
+!register : true
   <- .df_register("participant");
      .df_register("initiator").
```
Although technically possible, registering agents with both roles (initiator-participant) using a concatenated form, doesn't serve any functional purpose. The internal action [.df_register](https://jason-lang.github.io/api/jason/stdlib/df_register.html) is typically useful when agents have distinct roles. However, in this case where agents hold the same multiple roles (participant-initiator), registering them as such won't help in distinguishing between roles in auctions:
```asl
+!register : true
   <- .df_register("initiator-participant").
```
Instead, consider defining a shared .asl file for all agents, where role functionalities are represented as plans:
```asl
// Initiator's Plan: initiate an auction for a customer
+customer(C) : not auction(C)  // No ongoing auction for this customer yet
   <- +auction(C);
      announce(auction(C));  // Add the belief "auction(C)" in the belief bases of all the agents
      +participate(C);
      !request_bids(C);
      ...

// Participant's Plan: participate in an auction for a customer
+participate(C)  // A request received from an initiator (or self) to join the auction
    <- !submit_bid(C);
       ...
```

## 🛎 I have more questions

Didn't find what you were looking for? No worries! Send us an email and we'll help you get the answers you need:

- **Natalia Koliou:** [mtn2205@unipi.gr](mailto:mtn2205@unipi.gr)
- **Chris Kyriazopoulos:** [mtn2207@unipi.gr](mailto:mtn2207@unipi.gr)

<sup> 📢 Remember, your curiosity can be the golden nugget someone else is looking for. It's all about learning together, and together, we make learning awesome! So, go ahead, ask your questions and spark those "aha" moments for someone else. </sup>
