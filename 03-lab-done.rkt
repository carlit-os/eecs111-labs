;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Structs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define EPSILON 0.0000001)

; A NonnegativeNumber is a Number in [0, +inf.0)

; A CartesianCoord is (make-cart Number Number)
(define-struct cart (x y))
; interp. (make-cart x y) represents the Cartesian point (x, y)

; A PolarCoord is (make-polr NonnegativeNumber Number)
(define-struct polr (r theta))
; interp. if `p` is a PolarCoord then (polr-r p) is the distance from
; the origin, and (polr-theta p) is the is the angle, counterclockwise,
; between the point and the x-axis.

;; Note: a point with polar coordinate (r, θ) can be converted to and
;; from the standard coordinate system (x, y) by the formulae
;;
;;     x = r cos(θ)
;;     y = r sin(θ)
;;          __________
;;     r = √ x^2 + y^2
;;     θ = atan2(y, x)
;;
;; (atan2 : https://en.wikipedia.org/wiki/Atan2#Definition_and_computation )
;;


; Exercise 1.1. Write the templates for doing structural decomposition
; on CartesianCoord and PolarCoord.

#;
(define (process-cart a-cart ...)
  ... (cart-x a-cart) ...
  ... (cart-y a-cart) ...)

#;
(define (process-polr a-polr ...)
  ... (polr-r a-polr) ...
  ... (polr-theta a-polr) ...)


; Exercise 1.2.  What are the constructors, selectors, and predicates
; for the structs `cart` and `polr`?  What are their signatures?

; The constructor of the cart struct is:
; make-cart : Number Number -> CartesianCoord

; The selectors of the cart struct are:
; cart-x : CartesianCoord -> Number
; cart-y : CartesianCoord -> Number

; The predicate of the cart struct is:
; cart? : Any -> Boolean
(check-expect (cart? (make-cart 4 18)) #true)
(check-expect (cart? (make-polr 5 pi)) #false)
(check-expect (cart? 9)                #false)


; The constructor of the polr struct is:
; make-polr : NonnegativeNumber Number -> PolarCoord

; The selectors of the polr struct are:
; polr-r : PolarCoord -> NonnegativeNumber
; polr-theta : PolarCoord -> Number

; The predicate of the polr struct is:
; polr? : Any -> Boolean

(check-expect (polr? (make-cart 4 18)) #false)
(check-expect (polr? (make-polr 5 pi)) #true)
(check-expect (polr? 9)                #false)


;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Itemization ;;;;;;;;;;;;;;;;;;;;;;;;;

; A Point is one of:
; - (make-cart Number Number)
; - (make-polr NonnegativeNumber Number)
; - "origin"

; Exercise 2.1. Given an interpretation for the point data type.

; The Point data type represents a point on the Euclidean plane. If `p`
; is a Point then it is in one of these three forms:
;  - if (cart? p) then it represents the Euclidean position with x
;    coordinate (cart-x p) and y coordinate (cart-y p);
;  - if (polr? p) then it represents the polar position with radius
;    (polr-r p) and angle (polr-theta p);
;  - otherwise it is "origin".


; Exercise 2.2. Write a template (i.e., structural decomposition) for
; processing the Point data type.

; process-point : Point ... -> ...
; Template for Point.
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


; Exercise 3. Design a function distance-to-origin that, when given a
; Point, computes the distance between that Point and the origin.

; distance-to-origin : Point -> NonnegativeNumber
; Compute the distance of a point to the origin
;
; Examples:
; - The distance of (3, 4) to the origin is 5.                  _
; - The distance of polar coordinate (√2, π) to the origin is  √2.
; - The distance of "origin" to the origin is 0.
;
; Strategy: struct decomp
(define (distance-to-origin point)
  (cond
    [(cart? point)  (sqrt (+ (sqr (cart-x point)) (sqr (cart-y point))))]
    [(polr? point)  (polr-r point)]
    [else           0]))

(check-within (distance-to-origin (make-cart 3 4)) 5 EPSILON)
(check-within (distance-to-origin (make-polr (sqrt 2) pi)) (sqrt 2) EPSILON)
(check-within (distance-to-origin "origin") 0 EPSILON)


;;;;;;;;;;;;;;;;;;;;;;; PART III : Put Them Together ;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 4. See 03-lab-timers-done.rkt
