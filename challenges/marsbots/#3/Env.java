package example;

import jason.asSyntax.*;
import jason.environment.Environment;
import jason.environment.grid.GridWorldModel;
import jason.environment.grid.GridWorldView;
import jason.environment.grid.Location;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.util.Random;
import java.util.logging.Logger;

public class Env extends Environment {

    public static final int NbAgs = 2;
    public static final int GSize = 7;
    public static final int GARB  = 16; // garbage mask

    public static final Term    ns = Literal.parseLiteral("next(slot)");
    public static final Term    pg = Literal.parseLiteral("pick(garb)");
    public static final Term    dg = Literal.parseLiteral("drop(garb)");
    public static final Term    bg = Literal.parseLiteral("burn(garb)");
    public static final Literal gr1 = Literal.parseLiteral("garbage(r1)");
    public static final Literal gd = Literal.parseLiteral("garbage(d)");

    public Random random = new Random(System.currentTimeMillis());
    static Logger logger = Logger.getLogger(Env.class.getName());

    private MarsModel model;
    private MarsView  view;

    @Override
    public void init(String[] args) {
        model = new MarsModel();
        view  = new MarsView(model);
        model.setView(view);
        updatePercepts();
    }

    @Override
    public boolean executeAction(String ag, Structure action) {
        logger.info(ag+" doing: "+ action);
        try {
            if (action.equals(ns)) {
                model.nextSlot();
            } else if (action.getFunctor().equals("move_towards")) {
                int x = (int)((NumberTerm)action.getTerm(0)).solve();
                int y = (int)((NumberTerm)action.getTerm(1)).solve();
                model.moveTowards(x,y);
            } else if (action.equals(pg)) {
                model.pickGarb();
            } else if (action.equals(dg)) {
                model.dropGarb();
            } else if (action.equals(bg)) {
                model.burnGarb();
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        updatePercepts();

        try {
            if (random.nextInt(200) < 10) {
                model.generateRandomGarbage();
            }
            Thread.sleep(200);
        } catch (Exception e) {}
        informAgsEnvironmentChanged();
        return true;
    }

    void updatePercepts() {
        clearPercepts();

        // 0 and 1 are agents' r1 and d masks respectively
        Location r1Loc = model.getAgPos(0);
        Location dLoc = model.getAgPos(1);

        Literal posR1 = Literal.parseLiteral("pos(r1," + r1Loc.x + "," + r1Loc.y + ")");
        Literal posD = Literal.parseLiteral("pos(d," + dLoc.x + "," + dLoc.y + ")");

        addPercept(posR1);
        addPercept(posD);

        if (model.hasObject(GARB, r1Loc)) {
            addPercept(gr1);
        }
        if (model.hasObject(GARB, dLoc)) {
            addPercept(gd);
        }
    }

    class MarsModel extends GridWorldModel {

        public static final int MErr = 2; // max error in pick garb
        int nerr; // number of tries of pick garb
        boolean r1HasGarb = false;

        //Random random = new Random(System.currentTimeMillis());

        private MarsModel() {
            super(GSize, GSize, NbAgs);

            // initial location of agents
            try {
                setAgPos(0, 0, 0);

                Location dLoc = new Location(GSize/2, GSize/2);
                setAgPos(1, dLoc);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        void generateRandomGarbage() {
            int i = random.nextInt(getWidth());
            int j = random.nextInt(getHeight());
            add(GARB, i, j);
        } 

        void nextSlot() throws Exception {
            Location r1 = getAgPos(0);
            r1.x++;
            if (r1.x == getWidth()) {
                r1.x = 0;
                r1.y++;
            }
            // finished searching the whole grid
            if (r1.y == getHeight()) {
                r1.x = 0;
                r1.y = 0;
            }
            setAgPos(0, r1);
            setAgPos(1, getAgPos(1));
        }

        void moveTowards(int x, int y) throws Exception {
            Location r1 = getAgPos(0);
            if (r1.x < x)
                r1.x++;
            else if (r1.x > x)
                r1.x--;
            if (r1.y < y)
                r1.y++;
            else if (r1.y > y)
                r1.y--;
            setAgPos(0, r1);
            setAgPos(1, getAgPos(1));
        }

        void pickGarb() {
            if (model.hasObject(GARB, getAgPos(0))) {
                // sometimes the "picking" action doesn't work but never more than MErr times
                if (random.nextBoolean() || nerr == MErr) {
                    remove(GARB, getAgPos(0));
                    nerr = 0;
                    r1HasGarb = true;
                } else {
                    nerr++;
                }
            }
        }
        void dropGarb() {
            if (r1HasGarb) {
                r1HasGarb = false;
                add(GARB, getAgPos(0));
            }
        }
        void burnGarb() {
            if (model.hasObject(GARB, getAgPos(1))) {
                remove(GARB, getAgPos(1));
            }
        }
    }

    class MarsView extends GridWorldView {

        public MarsView(MarsModel model) {
            super(model, "Mars World", 600);
            defaultFont = new Font("Arial", Font.BOLD, 18);
            setVisible(true);
            repaint();
        }

        @Override
        public void draw(Graphics g, int x, int y, int object) {
            switch (object) {
            case Env.GARB:
                drawGarb(g, x, y);
                break;
            }
        }

        @Override
        public void drawAgent(Graphics g, int x, int y, Color c, int id) {
            String label = "D";
            c = Color.blue;
            if (id == 0) {
                label = "R"+(id+1);
                c = Color.yellow;
                if (((MarsModel)model).r1HasGarb) {
                    label += " - G";
                    c = Color.orange;
                }
            }
            super.drawAgent(g, x, y, c, -1);
            if (id == 0) {
                g.setColor(Color.black);
            } else {
                g.setColor(Color.white);
            }
            super.drawString(g, x, y, defaultFont, label);
            repaint();
        }

        public void drawGarb(Graphics g, int x, int y) {
            super.drawObstacle(g, x, y);
            g.setColor(Color.white);
            drawString(g, x, y, defaultFont, "G");
        }

    }
}