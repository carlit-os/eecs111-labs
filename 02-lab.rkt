;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 1. Please design a new class of data, named Combination, to
;; represent all possible orders of one ravioli filling with one sauce.
;; Write a comprehensive data definiton for Combination, which includes:
;;
;; - the definition of Combination itself (in a comment),
;; - a matching define-struct for BSL (not in a comment),
;; - an interpretation of the fields,
;; - a constant named SQUASHROOM-EXAMPLE defined to be the Combination that
;;   represents butternut squash filling in wild mushroom sauce, and
;; - a template for structurally decomposing a Combination.
;;
;; (You may want to refer to Homework 0 for the original problem or
;; Homework 1 for your definitions of Filling and Sauce:
;;  - http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/0.html
;;  - http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/1.html )

#| [YOUR CODE HERE] |#

(define SQUASHROOM-EXAMPLE
  "I'm a String, but I should be replaced with a Combination")


;; Exercise 2. Please design a function,
;;
;;     describe-order : Combination -> String
;;
;; that formats a Combination into a textual description according to
;; the check-expect below.

#| [YOUR CODE HERE] |#

;; (An example / test case)
#;
(check-expect
 (describe-order SQUASHROOM-EXAMPLE)
 "Ravioli with butternut squash filling and wild mushroom sauce.")


;; Exercise 3. John loves only cream sauce and no others. Please design a
;; function john-favorite : Combination -> Combination that changes the sauce
;; of an arbitrary order to be cream.

#| [YOUR CODE HERE] |#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : cond ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4. Yesterday, a clerk of Dave’s New Kitchen felt sleepy and
;; accidentally swapped the cream sauce and the wild mushroom sauce. As a
;; result, the orders were all wrong. Please design a function
;; actual-combination : Combination -> Combination that computes the actual
;; Combination served to the customer.
;;
;; Hint: You should design *two* functions and compose them to finish the job.
;; One of them should use structural decomposition on Combination and the other
;; should use structural decomposition on Sauce.

#| [YOUR CODE HERE] |#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART III : big-bang ;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 5. Please lookup big-bang in the Racket Help Desk (try to
;; find it!) and answer the following questions:

;; - How would the behavior of following code snippet differ from what we
;;   have seen so far?
#;
(big-bang WORLD0
  [on-tick advance-world 5]
  ...)

;; - How would the behavior of following snippet differ from what we have
;;   seen so far?
#;
(big-bang WORLD0
  [to-draw paint-scene WIDTH HEIGHT]
  ...)

;; - What would on-release do in the following code snippet? What kind
;;   of situation might you use on-release for?
#;
(big-bang WORLD0
  [on-release change-world-state]
  ...)

