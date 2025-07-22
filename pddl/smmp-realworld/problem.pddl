(define (problem serve-tissue) (:domain physical-exp)
(:requirements :derived-predicates :typing :strips :equality :negative-preconditions :disjunctive-preconditions :conditional-effects)
(:objects 
    
    

)

(:init
    ;todo: put the initial state's facts and numeric values here
    (RobotAbleToPick Robot)
    (IsNotLocation Opened)
    (IsNotLocation Closed)


    (RigiObj Tissue)
    (ArtiObj Closet)
    (ArtiObj Drawer)

    (ValidState Closet Closed)
    (ValidState Drawer Closed)
    (ValidState Tissue InDrawer)

    ;Let's Ignore InValidState for now see what is gonna happen

    (IsOccupied InDrawer)

    (IsXYPlane OnGlassyTable)
    (IsXYPlane OnTeapoy)

    (ContainSpace Drawer InDrawer)

    (FreeHandReachable OnGlassyTable)
    (FreeHandReachable OnTeapoy)
    (FreeHandReachable Opened)
    (FreeHandReachable Closed)

)

(:goal (and
    ;todo: put the goal condition here
    (ValidState Drawer Closed)
    (ValidState Closet Closed)
    (ValidState Tissue OnTeapoy)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
