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

(defrule preexisting-relation
    ?x <- (start)
=>
    (assert (question "relation;3;What kind of preexisting relationship do you have with this person?;Personal;Professional;Other;personal;professional;other"))
    (retract ?x)
)

(defrule relation-personal
    (relation personal)
=>
    (assert (question "is_related;2;Are you related?;yes;no;true;false"))
)

(defrule related
    (is_related true)
=>
    (assert (question "by_blood;2;By blood?;yes;no;true;false"))
)

;-----------------------------------------------------------------
;                       BY BLOOD? YES
;-----------------------------------------------------------------

(defrule blood-relation
    (by_blood true)
=>
    (assert (question "close_family_member;2;How close are you related?;It's my brother, sister, first cousin, aunt, uncle, parent, grandparent or child;It's my second cousin, half-cousin or more distant;true;false"))
)

(defrule absolutely-not
    (or
        (close_family_member true)
        (woody_allen false)
        (from_childhood true)
        (profession teacher)
        (still_dating true)
        (are_friends false)
        (move_to_japan false)
        (is_farmer false)
    )
=>
    (printout t "ABSOLUTELY NOT!!!" crlf)
    (assert (finish "ABSOLUTELY NOT!!!"))
)

(defrule distant-family
    (close_family_member false)
=>
    (assert (question "desperate_love;2;Are you really in love or just desperate?;God, I am so desperate;No, it's really love, I'm sure;true;false"))

)

(defrule hang-in-there
    (or
        (desperate_love true)
        (live_remotely false)
    )
=>
    (printout t "Hang in there, pal. You'll meet someone else." crlf)
    (assert (finish "Hang in there, pal. You'll meet someone else."))
)

(defrule is-not-desperated
    (desperate_love false)
=>
    (assert (question "live_remotely;2;Do you live in a sparsely populated area? Or the South?;yes;no;true;false"))
)

(defrule guess-its-ok
    (or
        (live_remotely true)
        (from_childhood false)
        (is_farmer true)
        (live_japan true)
        (move_to_japan true)
    )
=>
    (printout t "I guess it's OK, but you should probably keep it downlow." crlf)
    (assert (finish "I guess it's OK, but you should probably keep it downlow."))
)

;-----------------------------------------------------------------
;                       BY BLOOD? NO
;-----------------------------------------------------------------

(defrule no-blood-family
    (by_blood false)
=>
    (assert (question "sibling_or_child;2;How are you related?;It's my brother's wife's cousin if you can believe it;It's my step or adopted sibling or child;false;true"))
)

(defrule make-it-happen
    (or
        (sibling_or_child false)
        (woody_allen true)
    )  
=>
    (printout t "Make it happen, captain!" crlf)
    (assert (finish "Make it happen, captain!"))
)

(defrule no-blood-younger
    (sibling_or_child true)
=>
    (assert (question "parents_married;2;Are the parents still married?;yes;no;true;false"))
)

(defrule parents-still-married
    (parents_married true)
=>
    (assert (question "woody_allen;2;Are you Woody Allen?;yes;no;true;false"))
)

(defrule parents-not-married
    (parents_married false)
=>
    (assert (question "from_childhood;2;Did you grow up together, like from childhood?;yes;no;true;false"))
)

;-----------------------------------------------------------------
;                       NOT RELATED
;-----------------------------------------------------------------

(defrule not-related
    (is_related false)
=>
    (assert (question "friend;8;Who is this person to you?;It's my missed connection;It's my best friend's sibling;It's my dealer;It's my roommate;It's my soulmate;It's my cellmate;It's my dungeon master;It's my high school crush;missed_connection;bf_sibling;dealer;roommate;soulmate;cellmate;dungeon_master;school_crush"))
)

(defrule friend-missed-connection
    (friend missed_connection)
=>
    (assert (question "lonely;2;How lonely are you?;A little;Not at all;true;false"))
)

(defrule friend-best-friend-sibling
    (friend bf_sibling)
=>
    (assert (question "crazy;2;Are you crazy?;I don't think so;A little;false;true"))
)

(defrule friend-dealer
    (friend dealer)
=>
    (assert (question "get_high;2;Do you wanna get high?;yes;no;true;false"))
)

(defrule friend-roommate
    (friend roommate)
=>
    (assert (question "drama;2;Do you like drama?;yes;no;true;false"))
)

(defrule friend-soulmate
    (friend soulmate)
=>
    (assert (question "done_with_sex;2;Are you done having sex with other people?;yes;no;true;false"))
)

(defrule friend-cellmate
    (friend cellmate)
=>
    (assert (question "any_choice;2;Do you really have a choice in the matter?;yes;no;true;false"))
)

(defrule friend-dungeon-master
    (friend dungeon_master)
=>
    (printout t "Yes, for the love of God, someone please have sex with the dungeon master!" crlf)
    (assert (finish "Yes, for the love of God, someone please have sex with the dungeon master!"))
)

(defrule friend-school-crush
    (friend school_crush)
=>
    (printout t "You've missed the point of this chart. And you disgust me." crlf)
    (assert (finish "You've missed the point of this chart. And you disgust me."))
)

;-----------------------------------------------------------------
;                       VARIOUS FRIENDS
;-----------------------------------------------------------------

(defrule screw-bone-hmmm
    (or
        (lonely little)
        (crazy true)
        (get_high true)
        (profession professor)
        (author_only_love today)
        (CRAZY false)
        (health_risk false)
        (job_sucks true)
    )
=>
    (printout t "Screw + bone + ( ͡° ͜ʖ ͡°)" crlf)
    (assert (finish "Screw + bone + ( ͡° ͜ʖ ͡°)"))
)

(defrule bad-liar
    (or
        (lonely not_at_all)
        (crazy false)
    )
=>
    (printout t "You're a bad liar!" crlf)
    (assert (finish "You're a bad liar!"))
)

(defrule probably-better-not
    (or
        (get_high false)
        (drama false)
        (done_with_sex true)
        (any_choice true)
        (restraining_order false)
        (author_only_love never)
        (CRAZY true)
        (kids_return false)
        (nyc_or_sf false)
        (health_risk true)
        (job_sucks false)
        (date_if_lived false)
    )
=>
    (printout t "PROBABLY BETTER NOT" crlf)
    (assert (finish "PROBABLY BETTER NOT"))
)

(defrule likes-drama
    (drama true)
=>
    (printout t "Awesome! Leaving the house and putting on clothes are two of the worst parts of dating, so this is actually one of the better decisions you'll ever make! Go for it!" crlf)
    (assert (finish "Awesome! Leaving the house and putting on clothes are two of the worst parts of dating, so this is actually one of the better decisions you'll ever make! Go for it!"))
)

(defrule done-with-sex
    (or    
        (done_with_sex true)
        (any_choice false)
    )
=>
    (printout t "Well, it's pretty obvious, but go ahead and give it a shot." crlf)
    (assert (finish "Well, it's pretty obvious, but go ahead and give it a shot."))
)

;-----------------------------------------------------------------
;                    PROFESSIONAL RELATION
;-----------------------------------------------------------------

(defrule professional-relation
    (relation professional)
=>
    (assert (question "profession;10;What's his/her profession?;It's my costar;It's my stalker;It's my therapist;It's my social worker;It's my landlord;It's my physician;It's my boss/coworker;It's my professor;It's my student;It's my teacher;costar;stalker;therapist;social_worker;landlord;physician;boss_coworker;professor;student;teacher"))
)

(defrule profession-costar
    (profession costar)
=>
    (assert (question "generate_roumors;2;Are you just trying to generate publicity and dispel certain rumors?;yes;no;true;false"))
)

(defrule profession-stalker
    (profession stalker)
=>
    (assert (question "restraining_order;2;Is there a restraining order involved?;yes;no;true;false"))
)

(defrule profession-therapist
    (profession therapist)
=>
    (assert (question "CRAZY;2;ARE YOU CRAZY?;Maybe a little;I don't think so;true;false"))
)

(defrule profession-social-worker
    (profession social_worker)
=>
    (assert (question "kids_return;2;Is this just an attempt to get your kids back?;yes;no;true;false"))
)

(defrule profession-landlord
    (profession landlord)
=>
    (assert (question "nyc_or_sf;2;Do you live in either New York or San Francisco?;yes;no;true;false"))
)

(defrule profession-physician
    (profession physician)
=>
    (assert (question "health_risk;2;Is your health at any serious risk?;yes;no;true;false"))
)

(defrule profession-boss-coworker
    (or
        (profession boss_coworker)
        (where_teach college)
    )
=>
    (assert (question "job_sucks;2;Does your job suck?;yes;no;true;false"))
)

(defrule profession-student
    (profession student)
=>
    (assert (question "where_teach;2;Where do you teach?;College;Anything below college;college;before_college"))
)

;-----------------------------------------------------------------
;                    PROFESSION SUB-QUESTIONS
;-----------------------------------------------------------------

(defrule robert-pattinson
    (generate_roumors true)
=>
    (printout t "Hi, Robert Pattinson." crlf)
    (assert (finish "Hi, Robert Pattinson."))
)

(defrule not-advised
    (generate_roumors false)
=>
    (printout t "Not advised, but we'll allow it if you make a sex tape." crlf)
    (assert (finish "Not advised, but we'll allow it if you make a sex tape."))
)

(defrule restraining-order-involved
    (restraining_order true)
=>
    (assert (question "author_only_love;2;When are you gonna realize that I'm the only one who's ever gonna love you?;Today!;Never;today;never"))
)

(defrule whatever-it-takes
    (or
        (kids_return true)
        (nyc_or_sf true)
    )
=>
    (printout t "Do whatever it takes!" crlf)
    (assert (finish "Do whatever it takes!"))
)

(defrule teach-kids
    (where_teach before_college)
=>
    (assert (question "thought_crime;2;Whoa. You're talking about having sex with a minor, right?;Yeah;No, of course not;true;true"))
)

(defrule thought-crime
    (thought_crime true)
=>
    (printout t "THOUGHT-CRIME! Our agents have been sent to your location. Resistance is useless." crlf)
    (assert (finish "THOUGHT-CRIME! Our agents have been sent to your location. Resistance is useless."))
)

;-----------------------------------------------------------------
;                       OTHER RELATION
;-----------------------------------------------------------------

(defrule relation-other
    (relation other)
=>
    (assert (question "obj;5;What is it?;It's a ghost that's been haunting me;It's my best friend's ex;It's my Xbox/Wii/PlayStation;It's my pet or other animal;It's my lovebot;ghost;ex;console;animal;lovebot"))
)

(defrule obj-ghost
    (obj ghost)
=>
    (assert (question "like_in_movie;2;Like in that Demi Moore/Patrick Swayze movie?;Yes, exactly like that!;No, it's really nothing like that!;true;false"))
)

(defrule obj-ex
    (obj ex)
=>
    (assert (question "still_dating;2;How long since they stopped dating?;Well, technically they haven't really...;Oh, it's been awhile;true;false"))
)

(defrule obj-console
    (obj console)
=>
    (assert (question "adult;2;How old are you, again?;I'm over 18;I'm under 18;true;false"))
)

(defrule obj-animal
    (obj animal)
=>
    (assert (question "want_date_animal;2;Seriously? Like, you want to date an animal?;yes;no;true;false"))
)

(defrule obj-lovebot
    (obj lovebot)
=>
    (assert (question "live_japan;2;Do you live in Japan?;yes;no;true;false"))
)

;-----------------------------------------------------------------
;                       OBJECT SUBQUESTIONS
;-----------------------------------------------------------------

(defrule like-in-movie
    (or
        (like_in_movie true)
        (date_if_lived true)
    )
=>
    (printout t "FUCK THAT GHOST" crlf)
    (assert (finish "FUCK THAT GHOST"))
)

(defrule not-like-in-movie
    (like_in_movie false)
=>
    (assert (question "date_if_lived;2;Would you dated this person when among the living?;yes;no;true;false"))
)

(defrule still-dating
    (still_dating false)
=>
    (assert (question "are_friends;2;Are they still friends? Or enemies?;They have sworn to kill each other on sight;They're friendly enough;false;true"))
)

(defrule are-friends
    (are_friends true)
=>
    (printout t "Clear it with your friend first. Bros over hos, right? Or vice versa, as the case may be." crlf)
    (assert (finish "Clear it with your friend first. Bros over hos, right? Or vice versa, as the case may be."))
)

(defrule is-adult
    (adult true)
=>
    (assert (question "want_to_be_alone;2;Do you want to be alone for the rest of your life?;yes;no;true;false"))
)

(defrule game-on
    (or
        (adult false)
        (want_to_be_alone true)
    )
=>
    (printout t "It's for the best right now. Game on!" crlf)
    (assert (finish "It's for the best right now. Game on!"))
)

(defrule take-a-shower
    (want_to_be_alone false)
=>
    (printout t "Put down the controller and go take a shower. Your genitals will thank you." crlf)
    (assert (finish "Put down the controller and go take a shower. Your genitals will thank you."))
)

(defrule want-date-animal
    (want_date_animal true)
=>
    (assert (question "is_farmer;2;Are you a farmer?;yes;no;true;false"))
)

(defrule dont-want-date-animal
    (want_date_animal false)
=>
    (printout t "Ok, well, not 'date' per se but... ABSOLUTELY NOT!!!" crlf)
    (assert (finish "Ok, well, not 'date' per se but... ABSOLUTELY NOT!!!"))
)

(defrule live-in-japan
    (live_japan false)
=>
    (assert (question "move_to_japan;2;Will you please move there to make the rest of us feel better?;yes;no;true;false"))
)
