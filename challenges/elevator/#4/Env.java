package example;
import jason.asSyntax.*;
import jason.environment.*;
import jason.asSyntax.parser.*;

public class Env extends Environment {

    Literal floor = Literal.parseLiteral("at(5)");
    Literal served = Literal.parseLiteral("served");
    
    int idx = 0;
    int idy = 1;

    @Override
    public void init(String[] args) {
        addPercept(floor);
    }

    @Override
    public boolean executeAction(String ag, Structure act) {

        String x = act.getTerm(idx).toString();
        String y = act.getTerm(idy).toString();
        
        Literal xfloor = Literal.parseLiteral("at(" + x + ")");
        Literal yfloor = Literal.parseLiteral("at(" + y + ")");

        removePercept(xfloor);
        addPercept(yfloor);
        
        addPercept(ag, served);
            
        informAgsEnvironmentChanged();
        return true;
    }
}
