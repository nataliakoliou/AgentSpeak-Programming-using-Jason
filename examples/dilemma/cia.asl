// CIA: an agent that coordinates the Prisoner's Dilemma game by facilitating communication between players, collecting their actions, and assigning rewards based on the payoff matrix.

payoff_matrix([
    reward(confess, confess, -7),
    reward(confess, lie, 0),
    reward(lie, confess, -10),
    reward(lie, lie, -1)
    ]).

all_actions_received(Episode,NP) :- .count(play(Episode,_)[source(_)], NA).

get_reward(Action1, Action2, Value) :- payoff_matrix(PM) & .member(reward(Action1, Action2, Value), PM).

!register.
!cnp(1).

+!register <- .df_register("initiator").

+!cnp(Episode) : Episode <= 5
   <- !call(Episode,LP);
      !bid(Episode,LP);
      !collect(Episode,LA);
      !reward(Episode,LA);
      .wait(2000);
      .print("--------------------------------------------------------------------------------");
      !cnp(Episode+1).

+!cnp(Episode) : .findall(score(Player, Value),total(Player, Value),LS) & LS \== []
   <- .print("[Episode ", Episode, "] Final scores are: ",LS, ".");
      .max(LS,score(WSc,WAg));
      .print("[Episode ", Episode, "] Winner announcement: ",WAg, " with score ", WSc, "!").

+!call(Episode,LP)
   <- .print("[Episode ", Episode, "] Waiting for players to choose an action.");
      .df_search("participant",LP);
      .print("[Episode ", Episode, "] Sending CFP to ",LP);
      .send(LP,tell,cfp(Episode));
      .wait(5000).

+!bid(Episode,LP)
   <- .wait(all_actions_received(Episode,.length(LP)), 10000, _);
      .print("[Episode ", Episode, "] I received actions from: ", LP, ".");
      .findall(action(P,A), play(_,A)[source(P)], ActionBeliefs);
      .print("Action belief base content: ", ActionBeliefs).

+!collect(Episode,LA) : .findall(choice(Action, Player),play(Episode,Action)[source(Player)],LA) & LA \== []
   <- .print("[Episode ", Episode, "] List of actions are ",LA, ".").

+!reward(Episode, []) <- .print("[Episode ", Episode, "] No actions to reward.").
+!reward(Episode, [choice(Action1, Player1), choice(Action2, Player2)]) : 
      get_reward(Action1, Action2, Value1) & 
      get_reward(Action2, Action1, Value2)
    <- .send(Player1, tell, add(Episode, Value1));
       .send(Player2, tell, add(Episode, Value2)).    

+!update(Value)[source(A)]
   <- -+total(A,Value)[source(A)];
      .findall(total(P,V), total(P,V), RewardBeliefs);
      .print("Reward belief base content: ", RewardBeliefs).