;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs Again ;;;;;;;;;;;;;;;;;;;;;;;;;

(define EPSILON 0.0000001)

; A NonnegativeNumber falls into the below interval:
; - A number greater than or equal to 0


; A CartesianCoord is (make-cart Number Number)
(define-struct cart (x y))
; interp. `x` and `y` represents the coordinate of a point on the x-y
; plane.


; A PolarCoord is (make-polr NonnegativeNumber Number)
(define-struct polr (r theta))
; interp. `r` and `theta` represents the polar coordinate of a point
; on the x-y plane. `r` is the distance to the origin and `theta` is
; the angle between the point and the x-axis.

;; Note: a point with polar coordinate (r, θ) can be converted to and
;; from the standard coordinate system (x, y) by the formulae
;;
;;     x = r cos(θ)
;;     y = r sin(θ)
;;          __________
;;     r = √ x^2 + y^2
;;     θ = atan2(y, x)
;; (atan2 : https://en.wikipedia.org/wiki/Atan2#Definition_and_computation )
;;


; Exercise 1.1. Write the template for doing structural decomposition
; on CartesianCoord and PolarCoord.

#;
(define (process-cart a-cart ...)
  ... (cart-x a-cart) ...
  ... (cart-y a-cart) ...)

#;
(define (process-polr a-polr ...)
  ... (polr-r a-polr) ...
  ... (polr-theta a-polr) ...)



; Exercise 1.2.  What are the constructors, selectors and the structure
; predicates the predicates of the structs `cart` and `polr`?
; What are their signatures?

; The constructor of the cart struct is:
; make-cart : Number Number -> CartesianCoord

; The selectors of the cart struct are:
; cart-x : CartesianCoord -> Number
; cart-y : CartesianCoord -> Number

; The predicate of the cart struct is:
; cart? : CartesianCoord -> Boolean
(check-expect (cart? (make-cart 4 18))
              #true)

; The constructor of the polr struct is:
; make-polr : NonnegativeNumber Number -> PolarCoord

; The selectors of the polr struct are:
; polr-r : PolarCoord -> NonnegativeNumber
; polr-theta : PolarCoord -> Number

; The predicate of the polr struct is:
; polr? : PolarCoord -> Boolean

(check-expect (cart? (make-polr 5 pi))
              #false)



;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Itemization ;;;;;;;;;;;;;;;;;;;;;;;;;

; A Point is one of:
; - (make-cart Number Number)
; - (make-polr NonnegativeNumber Number)
; - "origin"

; Exercise 2. What should be the interpretation of the Point data type?
; write a template that process the Point data type.

; The Point data type represents a point on the xy-plane. It is either the
; origin, or other points designated either by its cartesian coordinate
; or its polar coordinate.

#;
(define (process-point point ...)
  (cond
    [(cart? point)
     ... (cart-x point) ...
     ... (cart-y point) ...]
    [(polr? point)
     ... (polr-r point) ...
     ... (polr-theta point) ...]
    [(string=? point "origin")
     ...]))



; Exercise 3. Design a function distance-to-origin that, when given a Point,
; computes the distance between that Point and the origin.

; distance-to-origin : Point -> NonnegativeNumber
; Compute the distance of a point to the origin
;
; Examples:
; - The distance of (3, 4) to the origin is 5.                  _
; - The distance of polar coordinate (√2, π) to the origin is  √2.
; - The distance of "origin" to the origin is 0.
(define (distance-to-origin point)
  (cond
    [(cart? point) (sqrt (+ (sqr (cart-x point)) (sqr (cart-y point))))]
    [(polr? point) (polr-r point)]
    [(string=? point "origin") 0]))
(check-within (distance-to-origin (make-cart 3 4)) 5 EPSILON)
(check-within (distance-to-origin (make-polr (sqrt 2) pi)) (sqrt 2) EPSILON)
(check-within (distance-to-origin "origin") 0 EPSILON)



; Exercise 4. Remember the freezable countdown timer from 08-itemizations.rkt?
; Instead of having the timer freeze, let's change it to be a timer that can
; memoize at most two countdown records. Specifically, change the FCDT time
; to be this and update the template:

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

; When the space key is pressed, memoize the current countdown time in the
; records field. Specifically, toggle-fcdt should put the time in the records
; instead of freezing or thawing the timer:
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

; The function update-fcdt for make-frozen2 works the same as for make-frozen.
; When drawing the timer in draw-fcdt, please show both the current time
; and records in the fields frozen-record, frozen2-record1 and frozen2-record2.
