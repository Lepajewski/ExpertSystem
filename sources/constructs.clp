; SYSTEM EKSPERCKI
; CAN WE DATE?

; communication with python based on fact (question ""):
; "next_question_prefix;n_of_answers;question;answers[0..9];short_answers[0..9]"

;-----------------------------------------------------------------------
;                                START
;-----------------------------------------------------------------------

(deffacts dane
    (start)
)

; ;-----------------------------------------------------------------------
; ;                      PREEXISTING REALATION
; ;-----------------------------------------------------------------------

(defrule q_preexisting_relation
    ?x <- (start)
=>
    (assert (question "relation;3;What kind of preexisting relationship do you have with this person?;Personal;Proffesional;Other;personal;proffesional;other"))
    (retract ?x)
)

(defrule relation_personal
    (relation personal)
=>
    (assert (question "is_related;2;Are you related?;yes;no;true;false"))
)

(defrule related
    (relation personal)
    (is_related true)
=>
    (assert (question "by_blood;2;By blood?;yes;no;true;false"))
)

(defrule blood_relation
    (relation personal)
    (is_related true)
    (by_blood true)
=>
    (assert (question "close_family_member;2;How close are you related?;It's my brother, sister, first cousin, aunt, uncle, parent, grandparent or child;It's my second cousin, half-cousin or more distant;true;false"))
)

(defrule blood_family
    (relation personal)
    (is_related true)
    (by_blood true)
    (close_family_member true)
=>
    (printout t "ABSOLUTELY NOT!!!" crlf)
)

(defrule distant_family
    (relation personal)
    (is_related true)
    (by_blood true)
    (close_family_member false)
=>
    (assert (question "desperate_love;2;Are you really in love or just desperate?;God, I am so desperate;No, it's really love, I'm sure;true;false"))

)

(defrule is_desperated
    (relation personal)
    (is_related true)
    (by_blood true)
    (desperate_love true)
=>
    (printout t "Hang in there, pal. You'll meet someone else." crlf)
)

(defrule is_not_desperated
    (relation personal)
    (is_related true)
    (by_blood true)
    (desperate_love false)
=>
    (assert (question "live_remotely;2;Do you live in a sparsely populated area? Or the South?;yes;no;true;false"))
)

(defrule live_alone
    (relation personal)
    (is_related true)
    (by_blood true)
    (desperate_love false)
    (live_remotely true)
=>
    (printout t "I guess it's OK, but you should probably keep it downlow." crlf)
)

(defrule not_live_alone
    (relation personal)
    (is_related true)
    (by_blood true)
    (desperate_love false)
    (live_remotely false)
=>
    (printout t "Hang in there, pal. You'll meet someone else." crlf)
)

;-----------------------------------------------------------------
;                       BY BLOOD? NO
;-----------------------------------------------------------------

(defrule no_blood_family
    (relation personal)
    (is_related true)
    (by_blood false)
=>
    (assert (question "sibling_or_child;2;How are you related?;It's my brother's wife's cousin if you can believe it;It's my step or adopted sibling or child;false;true"))
)

(defrule no_blood_equal_age
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child false)
=>
    (printout t "Make it happen, captain!" crlf)
)

(defrule no_blood_younger
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
=>
    (assert (question "parents_married;2;Are the parents still married?;yes;no;true;false"))
)

(defrule parents_still_married
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married true)
=>
    (assert (question "woody_allen;2;Are you Woody Allen?;yes;no;true;false"))
)

(defrule woody-allen
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married true)
    (woody_allen true)
=>
    (printout t "Make it happen, captain!" crlf)
)

(defrule not-woody-allen
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married true)
    (woody_allen false)
=>
    (printout t "ABSOLUTELY NOT!!!" crlf)
)

(defrule parents-not-married
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married false)
=>
    (assert (question "from_childhood;2;Did you grow up together, like from childhood?;yes;no;true;false"))
)

(defrule from-childhood
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married false)
    (from_childhood true)
=>
    (printout t "ABSOLUTELY NOT!!!" crlf)
)

(defrule not-from-childhood
    (relation personal)
    (is_related true)
    (by_blood false)
    (sibling_or_child true)
    (parents_married false)
    (from_childhood false)
=>
    (printout t "I guess it's ok, but you should probably keep it downlow." crlf)
)

; (defrule not_related
;     (relation personal)
;     (is_related false)
; =>
;     (assert (question "friend;8;Who is this person to you?;It's my missed connection;It's my best friend's sibling;It's my dealer;It's my roomate;It's my soulmate;It's my cellmate;It's my dungeon master;It's my high school crush;missed_connection;bf_sibling;dealer;roomate;soulmate;cellmate;dungeon_master;school_crush"))
; )
