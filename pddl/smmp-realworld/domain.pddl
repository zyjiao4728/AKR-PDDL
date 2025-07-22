(define (domain physical-exp)


(:requirements :derived-predicates :typing :strips :equality :negative-preconditions :disjunctive-preconditions :conditional-effects)
    (:types
        state obj vkc - object
    )

    (:constants
        Robot - vkc
        Opened - state
        Closed - state
        Closet - obj
        Drawer - obj
        Tissue - obj
        GlassyTable - obj
        Teapoy -obj
        OnGlassyTable - state
        OnTeapoy - state
        InDrawer - state
    )

    (:predicates
        (ArtiObj ?o - obj)
        (RigiObj ?o - obj)
        (ToolObj ?o - obj)
        (FreeHandReachable ?s)
        (ToolReachable ?s)
        (ContainSpace ?o ?s)
        (OnRobot ?o - obj)
        (HasTool ?vkc - vkc)
        (ValidState ?o - obj ?s - state)
        (InValidState ?o - obj ?s - state)
        (RobotAbleToPick ?vkc - vkc)
        (IsNotLocation ?s)
        (IsXYPlane ?s)
        (IsOccupied ?s)
        (RobotAtCloset ?vkc)
        (RobotAtDrawer ?vkc)
        (RobotAtGlassyTable ?vkc)
        (RobotAtTeapoy ?vkc)
        (ClosetOpened)
        (DrawerOpened)
        
    )

    ; max 1 tool + 1 rigid/tool object in hand
    (:action pick-vkc
        :parameters (?o - obj ?s - state ?vkc - vkc)
        :precondition (and
            (ValidState ?o ?s)
            (RobotAbleToPick ?vkc)
            (not
                (and
                    (DrawerOpened)
                    (not (ClosetOpened))
                )
            )
            (not
                (and
                    (not (ClosetOpened))
                    (= ?o Drawer)
                    (= ?s Opened)
                )
            )
            (not
                (and
                    (RobotAtDrawer ?vkc)
                    (ClosetOpened)
                    (= ?s OnTeapoy)
                )
            )
            (not
                (and
                    (RobotAtGlassyTable ?vkc)
                    (ClosetOpened)
                    (= ?s OnTeapoy)
                )
            )
            (not
                (and
                    (RobotAtTeapoy ?vkc)
                    (ClosetOpened)
                    (= ?s OnGlassyTable)
                )
            )
            (not
                (and
                    (RobotAtTeapoy ?vkc)
                    (ClosetOpened)
                    (or
                        (= ?s InDrawer)
                        (= ?o Drawer)
                    )
                )
            )
            (or
                (and
                    (not (ArtiObj ?o))
                    (ToolReachable ?s)
                    (HasTool ?vkc)
                )
                (and
                    (not (ArtiObj ?o))
                    (FreeHandReachable ?s)
                )
                (and
                    ; cannot manipulate articulate object when holding a tool
                    (ArtiObj ?o)
                    (FreeHandReachable ?s)
                    (not (HasTool ?vkc))
                )
            )
        )
        :effect (and
            (not (ValidState ?o ?s))
            (OnRobot ?o)
            (when
                (and
                    (= ?o Closet)
                    (= ?s Opened)
                )
                (ClosetOpened)
            )
            (when
                (and
                    (= ?o Closet)
                    (= ?s Closed)
                )
                (not (ClosetOpened))
            )
            (when
                (and
                    (= ?o Drawer)
                    (= ?s Opened)
                )
                (DrawerOpened)
            )
            (when
                (and
                    (= ?o Drawer)
                    (= ?s Closed)
                )
                (not (DrawerOpened))
            )
            (when
                (= ?o GlassyTable)
                (RobotAtGlassyTable ?vkc)
            )
            (when
                (= ?o Teapoy)
                (RobotAtTeapoy ?vkc)
            )
            (when
                (= ?o Drawer)
                (RobotAtDrawer ?vkc)
            )
            (when
                (= ?o Closet)
                (RobotAtCloset ?vkc)
            )
            (when
                (and
                    (ToolObj ?o)
                    (HasTool ?vkc)
                )
                (not (RobotAbleToPick ?vkc))
            )
            (when
                (and
                    (ToolObj ?o)
                    (not (HasTool ?vkc))
                )
                (HasTool ?vkc)
            )
            (when
                ; when pick up a articulate/rigid object
                (not (ToolObj ?o))
                (not (RobotAbleToPick ?vkc))
            )
            (when
                (not (IsNotLocation ?s))
                (not (IsOccupied ?s))
            )
        )
    )

    (:action place-vkc
        :parameters (?o - obj ?s - state ?vkc - vkc)
        :precondition (and
            (OnRobot ?o)
            (not
                (and
                    (DrawerOpened)
                    (not (ClosetOpened))
                )
            )
            (not
                (and
                    (not (ClosetOpened))
                    (= ?o Drawer)
                    (= ?s Opened)
                )
            )
            (not
                (and
                    (RobotAtDrawer ?vkc)
                    (ClosetOpened)
                    (= ?s OnTeapoy)
                )
            )
            (not
                (and
                    (RobotAtGlassyTable ?vkc)
                    (ClosetOpened)
                    (= ?s OnTeapoy)
                )
            )
            (not
                (and
                    (RobotAtTeapoy ?vkc)
                    (ClosetOpened)
                    (= ?s OnGlassyTable)
                )
            )
            (not
                (and
                    (RobotAtTeapoy ?vkc)
                    (ClosetOpened)
                    (or
                        (= ?o Drawer)
                        (= ?s InDrawer)
                    )
                )
            )
            (or
                (and
                    (HasTool ?vkc)
                    (RigiObj ?o)
                    (IsXYPlane ?s)
                )
                (or
                    (not (HasTool ?vkc))
                    (ToolObj ?o)
                )
            )
            (or
                (IsNotLocation ?s)
                (not (IsOccupied ?s))
            )
            (or
                (ArtiObj ?o)
                (not (IsNotLocation ?s))
            )
            (or
                (and
                    (ToolReachable ?s)
                    (HasTool ?vkc)
                    (not (ToolObj ?o))
                )
                (FreeHandReachable ?s)
            )
            (or
                (and
                    ; Cannot place a tool if there is an object attached to it
                    (ToolObj ?o)
                    (RobotAbleToPick ?vkc)
                )
                (not (ToolObj ?o))
            )
            (not (InValidState ?o ?s))

        )
        :effect (and
            (ValidState ?o ?s)
            (not (OnRobot ?o))
            (when
                (and
                    (= ?o Closet)
                    (= ?s Opened)
                )
                (ClosetOpened)
            )
            (when
                (and
                    (= ?o Closet)
                    (= ?s Closed)
                )
                (not (ClosetOpened))
            )
            (when
                (and
                    (= ?o Drawer)
                    (= ?s Opened)
                )
                (DrawerOpened)
            )
            (when
                (and
                    (= ?o Drawer)
                    (= ?s Closed)
                )
                (not (DrawerOpened))
            )
            (when
                (= ?o GlassyTable)
                (RobotAtGlassyTable ?vkc)
            )
            (when
                (= ?o Teapoy)
                (RobotAtTeapoy ?vkc)
            )
            (when
                (= ?o Drawer)
                (RobotAtDrawer ?vkc)
            )
            (when
                (= ?o Closet)
                (RobotAtCloset ?vkc)
            )
            (when
                (not (ToolObj ?o))
                (RobotAbleToPick ?vkc)
            )
            (when
                ; use tool pick anthor tool
                (and
                    (ToolObj ?o)
                    (not (RobotAbleToPick ?vkc))
                )
                (RobotAbleToPick ?vkc)
            )
            (when
                (and
                    (ToolObj ?o)
                    (RobotAbleToPick ?vkc)
                )
                (not (HasTool ?vkc))
            )
            (when
                (and
                    (ArtiObj ?o)
                    (= ?s Opened)
                )
                (forall
                    (?room - state)
                    (when
                        (ContainSpace ?o ?room)
                        (FreeHandReachable ?room)
                    )
                )
            )
            (when
                (and
                    (ArtiObj ?o)
                    (= ?s Closed)
                )
                (forall
                    (?room - state)
                    (when
                        (ContainSpace ?o ?room)
                        (not (FreeHandReachable ?room))
                    )
                )
            )
            (when
                (not (IsNotLocation ?s))
                (IsOccupied ?s)
            )
        )
    )




)