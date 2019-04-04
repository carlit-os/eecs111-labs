;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 1. Please design a data definition, Combination, to represent all
;; possible orders of one ravioli filling with one sauce.
;;
;; Please follow the design recipe which includes a description (signature)
;; of Combination, a define-struct and an interpretation of the fields.
;; Also write down a template that does structural decomposition of Combination.
;;
;; (See: homework 0 and homework 1
;;  - Homework 0: http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/0.html
;;  - Homework 1: http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/1.html )

; A Combination is (make-comb Ravioli Sauce)
(define-struct comb (ravioli sauce))
; interp. `ravioli` is the filling of the ravioli and `sauce` is the choice of sauce

#;
(define (a-function comb ...)
  ... (comb-ravioli comb) ...
  ... (comb-sauce comb) ...)



;; Exercise 2a. Please design a function, describe-order : Combination -> String,
;; that computes a string description of a Combination following the example format.

; describe-order : Combination -> String
; Computes a string description of a Combination
; Examples
;
; - The description of the order (make-comb "butternut squash" "wild mushroom") is
;   "This order is a ravioli with butternut squash filling and the wild mushroom sauce."
;
; - The description of the order (make-comb "ricotta" "tomato") is
;   "This order is a ravioli with ricotta filling and the tomato sauce."
;
; Strategy: structural decomp.
(define (describe-order comb)
  (string-append
   "This order is a ravioli with "
   (comb-ravioli comb)
   " filling and the "
   (comb-sauce comb)
   " sauce."))

(check-expect
 (describe-order (make-comb "butternut squash" "wild mushroom"))
 "This order is a ravioli with butternut squash filling and the wild mushroom sauce.")

(check-expect
 (describe-order (make-comb "ricotta" "tomato"))
 "This order is a ravioli with ricotta filling and the tomato sauce.")



;; Exercise 2b. Evaluate the following expression step by step and write down
;; next to each step whether it is arithmetic, plugging or cond.
;;
;;     (describe-order (make-comb "butternut squash" "wild mushroom"))
;;
;; Please refer to 09-stepping.rkt on the course webpage.

(describe-order (make-comb "butternut squash" "wild mushroom"))
;; -[plug]->
#; (string-append
    "This order is a ravioli with "
    (comb-ravioli (make-comb "butternut squash" "wild mushroom"))
    " filling and the "
    (comb-sauce (make-comb "butternut squash" "wild mushroom"))
    " sauce.")
;; -[arith]->
#; (string-append
    "This order is a ravioli with "
    "butternut squash"
    " filling and the "
    (comb-sauce (make-comb "butternut squash" "wild mushroom"))
    " sauce.")
;; -[arith]->
#; (string-append
    "This order is a ravioli with "
    "butternut squash"
    " filling and the "
    "wild mushroom"
    " sauce.")
;; -[arith]->
#; "This order is a ravioli with butternut squash filling and the wild mushroom sauce."



;; Exercise 3. John loves only cream sauce and no others. Please design a
;; function john-favorite : Combination -> Combination that change the sauce
;; of an arbitrary order to "cream".

; john-favorite : Combination -> Combination
; Change the sauce of an order to "cream"
; Examples:
(check-expect (john-favorite (make-comb "butternut squash" "mushroom"))
              (make-comb "butternut squash" "cream"))
(check-expect (john-favorite (make-comb "ricotta" "tomato"))
              (make-comb "ricotta" "cream"))
; Strategy: structural decomp.
(define (john-favorite comb)
  (make-comb (comb-ravioli comb) "cream"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : cond ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4a. Yesterday, a clerk of Dave’s New Kitchen felt sleepy and accidentally
;; swapped the cream sauce and the wild mushroom sauce. As a result, the orders were
;; all wrong. Please design a function actual-combination : Combination -> Combination
;; that computes the actual Combination that was served to the customer.
;;
;; Hint: You should design *two* functions and compose them to finish the job.
;; One of them should use structural decomposition on Combination and the other
;; should use structural decomposition on Sauce.

; actual-sauce : Sauce -> Sauce
; Compute the actual sauce used by the clerk.
; Examples:
(check-expect (actual-sauce "tomato") "tomato")
(check-expect (actual-sauce "cream") "wild mushroom")
(check-expect (actual-sauce "wild mushroom") "cream")
; Strategy: structural decomp.
(define (actual-sauce sauce)
  (cond
    [(string=? sauce "tomato")        "tomato"]
    [(string=? sauce "cream")         "wild mushroom"]
    [(string=? sauce "wild mushroom") "cream"]))

; actual-combination : Combination -> Combination
; Compute the actual combination served to the customer.
; Example:
(check-expect
 (actual-combination (make-comb "butternut squash" "cream"))
 (make-comb "butternut squash" "wild mushroom"))
; Strategy: structural decomp. and function comp.
(define (actual-combination comb)
  (make-comb (comb-ravioli comb) (actual-sauce (comb-sauce comb))))



;; Exercise 4b. Evaluate the following expression step by step and write down
;; next to each step whether it is arithmetic, plugging or cond.
;;
;;     (actual-combination (make-comb "butternut squash" "cream"))

(actual-combination (make-comb "butternut squash" "cream"))
;; -[plug]->
#; (make-comb (comb-ravioli (make-comb "butternut squash" "cream"))
              (actual-sauce (comb-sauce (make-comb "butternut squash" "cream"))))
;; -[arith]->
#; (make-comb "butternut squash"
              (actual-sauce (comb-sauce (make-comb "butternut squash" "cream"))))
;; -[arith]->
#; (make-comb "butternut squash"
              (actual-sauce "cream"))
;; -[plug]->
#; (make-comb "butternut squash"
              (cond
                [(string=? "cream" "tomato")        "tomato"]
                [(string=? "cream" "cream")         "wild mushroom"]
                [(string=? "cream" "wild mushroom") "cream"]))
;; -[arith]->
#; (make-comb "butternut squash"
              (cond
                [#false                             "tomato"]
                [(string=? "cream" "cream")         "wild mushroom"]
                [(string=? "cream" "wild mushroom") "cream"]))
;; -[cond]->
#; (make-comb "butternut squash"
              (cond
                [(string=? "cream" "cream")         "wild mushroom"]
                [(string=? "cream" "wild mushroom") "cream"]))
;; -[arith]->
#; (make-comb "butternut squash"
              (cond
                [#true                              "wild mushroom"]
                [(string=? "cream" "wild mushroom") "cream"]))
;; -[cond]->
#; (make-comb "butternut squash"
              "wild mushroom")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART III : big-bang ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 5. Please lookup big-bang in the documents (try to find it!) and answer
;; the following questions to yourself:

;; - How does the behavior of following code differ from what we have seen so far?
#;
(big-bang
 (on-tick advance-world 5)
 ...)

;; - How does the behavior of following code differ from what we have seen so far?
#;
(big-bang
 (to-draw paint-scene WIDTH HEIGHT)
 ...)

;; - What does on-release do in the following code?
#;
(big-bang
 (on-release change-world-state)
 ...)
