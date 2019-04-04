;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 1. Please design a data definition, Combination, to represent all
;; possible orders of one ravioli filling with one sauce.
;;
;; Please follow the design recipe which includes a description (signature)
;; of Combination, a define-struct and an interpretation of the fields.
;; Also write down a template that does structural decomposition of Combination.
;;
;; (See: homework 0 and homework 1
;;  - HW0: http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/0.html
;;  - HW1: http://users.eecs.northwestern.edu/~jesse/course/eecs111/hw/1.html )

#| [YOUR CODE HERE] |#



;; Exercise 2a. Please design a function, describe-order : Combination -> String,
;; that computes a string description of a Combination following the example
;; format.

#| [YOUR CODE HERE] |#

; (An example and sample test case)
#;
(check-expect
 (describe-order (make-comb "butternut squash" "wild mushroom"))
 "This order is ravioli with butternut squash filling and wild mushroom sauce.")



;; Exercise 2b. Evaluate the following expression step by step and write down
;; next to each step whether it is arithmetic, plugging or cond.
;;
;;     (describe-order (make-comb "butternut squash" "wild mushroom"))
;;
;; Please refer to 09-stepping.rkt on the course webpage.



;; Exercise 3. John loves only cream sauce and no others. Please design a
;; function john-favorite : Combination -> Combination that change the sauce
;; of an arbitrary order to "cream".

#| [YOUR CODE HERE] |#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : cond ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4a. Yesterday, a clerk of Dave’s New Kitchen felt sleepy and
;; accidentally swapped the cream sauce and the wild mushroom sauce. As a
;; result, the orders were all wrong. Please design a function
;; actual-combination : Combination -> Combination that computes the actual
;; Combination served to the customer.
;;
;; Hint: You should design *two* functions and compose them to finish the job.
;; One of them should use structural decomposition on Combination and the other
;; should use structural decomposition on Sauce.

#| [YOUR CODE HERE] |#



;; Exercise 4b. Evaluate the following expression step by step and write down
;; next to each step whether it is arithmetic, plugging or cond.
;;
;;     (actual-combination (make-comb "butternut squash" "cream"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART III : big-bang ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 5. Please lookup big-bang in the documents (try to find it!) and
;; answer the following questions to yourself:

;; - How does the behavior of following code differ from what we have seen so
;; far?
#;
(big-bang WORLD0
          [on-tick advance-world 5]
          ...)

;; - How does the behavior of following code differ from what we have seen so
;; far?
#;
(big-bang WORLD0
          [to-draw paint-scene WIDTH HEIGHT]
          ...)

;; - What does on-release do in the following code?
#;
(big-bang WORLD0
          [on-release change-world-state]
          ...)
