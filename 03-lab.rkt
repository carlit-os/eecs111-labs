;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs Again ;;;;;;;;;;;;;;;;;;;;;;;;;

;; A NonnegativeNumber falls into the below interval:
;; - A number greater than or equal to 0


;; A CartesianCoord is (make-cart Number Number)
(define-struct cart (x y))
;; interp. `x` and `y` represents the coordinate of a point on the x-y
;; plane.


;; A PolarCoord is (make-polr NonnegativeNumber Number)
(define-struct polr (r theta))
;; interp. `r` and `theta` represents the polar coordinate of a point
;; on the x-y plane. `r` is the distance to the origin and `theta` is
;; the angle between the point and the x-axis.

;; Note: a point with polar coordinate (r, θ) can be converted to and
;; from the standard coordinate system (x, y) by the formulas
;;
;;     x = r cos(θ)
;;     y = r sin(θ)
;;          __________
;;     r = √ x^2 + y^2
;;     θ = atan2(y, x)
;; (atan2 : https://en.wikipedia.org/wiki/Atan2#Definition_and_computation )
;;


;; Exercise 1.1. Write the template for doing structural decomposition
;; on CartesianCoord and PolarCoord.

#| [YOUR CODE HERE] |#



;; Exercise 1.2.  What are the constructors, selectors and the structure
;; predicates the predicates of the structs `cart` and `polr`?
;; What are their signatures?

#| [YOUR CODE HERE] |#



;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Itemization ;;;;;;;;;;;;;;;;;;;;;;;;;

;; A Point is one of:
;; - (make-cart Number Number)
;; - (make-polr NonnegativeNumber Number)
;; - "origin"

;; Exercise 2. What should be the interpretation of the Point data type?
;; write a template that process the Point data type.

#| [YOUR CODE HERE] |#



;; Exercise 3. Design a function distance-to-origin that, when given a Point,
;; computes the distance between that Point and the origin.

#| [YOUR CODE HERE] |#



;;;;;;;;;;;;;;;;;;;;;;; PART III : put them together ;;;;;;;;;;;;;;;;;;;;;;;

;; Exercise 4. Remember the freezable countdown timer from 08-itemizations.rkt?
;; Instead of having the timer freeze, let's change it to be a timer that can
;; memoize at most two countdown records. Specifically, change the FCDT time
;; to be this and update the template:

; A FCDT (freezable count-down timer) is one of:
; - (make-running CDT)
; - (make-frozen CDT CDT)
; - (make-frozen2 CDT CDT CDT)

; Interpretation:
; - (make-running t) means that t is the time remaining
; - (make-frozen t d) memoizes one record d and continue counting with t
; - (make-frozen2 t d d2) memoizes two records d, d2 and continue counting with t
(define-struct running (timer))
(define-struct frozen (timer record))
(define-struct frozen2 (timer record1 record2))

;; When the space key is pressed, memoize the current countdown time in the
;; records field. Specifically, toggle-fcdt should put the time in the records
;; instead of freezing or thawing the timer:
#|
Examples:

(check-expect (toggle-fcdt
               (make-running (make-hms 1 23 8)))
              (make-frozen (make-hms 1 23 8) (make-hms 1 23 8)))

(check-expect (toggle-fcdt
               (make-frozen (make-hms 1 23 8) (make-hms 7 0 2)))
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 7 0 2)))

(check-expect (toggle-fcdt
               (make-frozen2 (make-hms 1 23 8) (make-hms 4 59 0) (make-hms 7 0 2)))
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 4 59 0)))
|#

;; The function update-fcdt for make-frozen2 works the same as for make-frozen.
;; When drawing the timer in draw-fcdt, please show both the current time
;; and records in the fields frozen-record, frozen2-record1 and frozen2-record2.
