;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-08-itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;; Itemizations ;;;;;

(require 2htdp/universe)
(require 2htdp/image)


;                                                              
;                                                              
;                                                              
;                                                              
;   ;;;;;;                           ;;                  ;;;   
;   ;;   ;;                          ;;                ;;;;;   
;   ;;    ;;                         ;;                ;  ;;   
;   ;;    ;;    ;;;;;     ;;  ;;   ;;;;;;;                ;;   
;   ;;    ;;   ;    ;;    ;;;;  ;    ;;                   ;;   
;   ;;   ;;         ;;    ;;;        ;;                   ;;   
;   ;;;;;;      ;;;;;;    ;;         ;;                   ;;   
;   ;;        ;;;   ;;    ;;         ;;                   ;;   
;   ;;        ;;    ;;    ;;         ;;                   ;;   
;   ;;        ;;    ;;    ;;         ;;                   ;;   
;   ;;        ;;   ;;;    ;;         ;;                   ;;   
;   ;;         ;;;; ;;    ;;          ;;;;             ;;;;;;;;
;                                                              
;                                                              
;                                                              
;                                                              


; A TrainCar is one of:
; -- (make-box-car Number Number Number)
; -- (make-hopper Number Number Number)
; -- (make-tank-car Number Number)
; -- (make-passenger-car Number)
; -- "engine"
(define-struct box-car (length width height))
(define-struct hopper (length width height))
(define-struct tank-car (length radius))
(define-struct passenger-car (passengers))

; Example TrainCars:
(define BOX-CAR-EX (make-box-car 50 10 8))
(define HOPPER-EX (make-hopper 50 10 8))
(define TANK-CAR-EX (make-tank-car 50 5))
(define PASSENGER-CAR-EX (make-passenger-car 80))

; process-traincar : TrainCar ... -> ...
; Template for TrainCar
#;
(define (process-traincar tc ...)
  (cond
    [(box-car? tc) ... (box-car-length tc) ...
                   ... (box-car-width tc) ...
                   ... (box-car-height tc) ...]
    [(hopper? tc) ... (hopper-length tc) ...
                  ... (hopper-width tc) ...
                  ... (hopper-height tc) ...]
    [(tank-car? tc) ... (tank-car-length tc) ...
                    ... (tank-car-radius tc) ...]
    [(passenger-car? tc) ... (passenger-car-passengers tc) ...]
    [else ...]))


; freight-volume : TrainCar -> Number
; Finds the volume of a train car
;
; Examples:
;  - volume of 50-by-10-by-8 box car is 4000
;  - volume of 50-by-5 tank car is 1250π
;  - volume of passenger car or engine is 0
;
; Strategy: struct. decomp.
(define (freight-volume tc)
  (cond
    [(box-car? tc)      (* (box-car-length tc)
                           (box-car-width tc)
                           (box-car-height tc))]
    [(hopper? tc)       (* 1/2
                           (hopper-length tc)
                           (hopper-width tc)
                           (hopper-height tc))]
    [(tank-car? tc)     (* (tank-car-length tc)
                           pi
                           (sqr (tank-car-radius tc)))]
    [(passenger-car? tc) 0]
    [else                0]))

(check-expect (freight-volume (make-box-car 3 4 5))
              60)
(check-expect (freight-volume (make-hopper 3 4 5))
              30)
(check-within (freight-volume (make-tank-car 3 4))
              (* 3 pi (sqr 4))
              0.001)
(check-expect (freight-volume (make-passenger-car 80))
              0)
(check-expect (freight-volume "engine")
              0)


; freight-car? : TrainCar -> Boolean
; Finds out whether a train car is a freight car.
;
; Examples:
;  - tank car => true
;  - passenger car => false
;
; Strategy: struct. decomp.
(define (freight-car? tc)
  (cond
    [(box-car? tc)       true]
    [(hopper? tc)        true]
    [(tank-car? tc)      true]
    [(passenger-car? tc) false]
    [else false]))

(check-expect (freight-car? (make-box-car 3 4 5))
              true)
(check-expect (freight-car? (make-hopper 3 4 5))
              true)
(check-expect (freight-car? (make-tank-car 3 4))
              true)
(check-expect (freight-car? (make-passenger-car 80))
              false)
(check-expect (freight-car? "engine")
              false)


; passenger-capacity : TrainCar -> Number
; Finds out how many passengers can ride in the given car
;
; Examples:
;  - box car => 0
;  - (make-passenger-car 80) => 80
;  - "engine" => 1
;
; Strategy: struct. decomp.
(define (passenger-capacity tc)
  (cond
    [(box-car? tc)       0]
    [(hopper? tc)        0]
    [(tank-car? tc)      0]
    [(passenger-car? tc) (passenger-car-passengers tc)]
    [else                1]))

(check-expect (passenger-capacity BOX-CAR-EX)
              0)
(check-expect (passenger-capacity HOPPER-EX)
              0)
(check-expect (passenger-capacity TANK-CAR-EX)
              0)
(check-expect (passenger-capacity (make-passenger-car 87))
              87)
(check-expect (passenger-capacity "engine")
              1)


;                                                              
;                                                              
;                                                              
;                                                              
;   ;;;;;;                           ;;                ;;;;;   
;   ;;   ;;                          ;;               ;;   ;;  
;   ;;    ;;                         ;;               ;     ;; 
;   ;;    ;;    ;;;;;     ;;  ;;   ;;;;;;;                  ;; 
;   ;;    ;;   ;    ;;    ;;;;  ;    ;;                     ;; 
;   ;;   ;;         ;;    ;;;        ;;                    ;;; 
;   ;;;;;;      ;;;;;;    ;;         ;;                   ;;;  
;   ;;        ;;;   ;;    ;;         ;;                  ;;;   
;   ;;        ;;    ;;    ;;         ;;                 ;;;    
;   ;;        ;;    ;;    ;;         ;;                ;;;     
;   ;;        ;;   ;;;    ;;         ;;               ;;;      
;   ;;         ;;;; ;;    ;;          ;;;;            ;;;;;;;; 
;                                                              
;                                                              
;                                                              
;                                                              


; A Length is a PositiveNumber

; A Shape is one of
; - (make-rect Length Length)
; - (make-circ Length)
; - (make-tri Length Length Length)
;
; Interpretation:
; - (make-rect w h) is a w-by-h rectangle
; - (make-circ r) is a circle of radius r
; - (make-tri a b c) is a triangle with side lengths a, b, and c
(define-struct rect (width height))
(define-struct circ (radius))
(define-struct tri (a b c))

;; Template for Shape
#;
(define (process-shape shape ...)
  (cond
    [(rect? shape)
     ... (rect-width shape) ...
     ... (rect-height shape) ...]
    [(circ? shape)
     ... (circ-radius shape) ...]
    [(tri? shape)
     ... (tri-a shape) ...
     ... (tri-b shape) ...
     ... (tri-c shape) ...]))


; shape-perimeter : Shape -> Number
; Computes the perimeter of a shape
;
; Examples:
;  - (make-rect 4 7) => 22
;  - (make-circ 3) => 6π
;  - (make-tri 11 13 15) => 39
;
; Strategy: struct. decomp.
(define (shape-perimeter shape)
  (cond
    [(rect? shape)
     (* 2 (+ (rect-width shape) (rect-height shape)))]
    [(circ? shape)
     (* 2 pi (circ-radius shape))]
    [(tri? shape)
     (+ (tri-a shape) (tri-b shape) (tri-c shape))]))

(check-expect (shape-perimeter (make-rect 4 7)) 22)
(check-within (shape-perimeter (make-circ 3)) (* 6 pi) 0.00001)
(check-expect (shape-perimeter (make-tri 11 13 15)) 39)


; shape-area : Shape -> Number
; Computes the area of shape
;
; Examples:
;  - (make-rect 4 7) => 28
;  - (make-circ 9) => 81π
;  - (make-tri 3 4 5) => 6
;
; Strategy: struct. decomp.
(define (shape-area shape)
  (cond
    [(rect? shape)
     (* (rect-width shape) (rect-height shape))]
    [(circ? shape)
     (* pi (sqr (circ-radius shape)))]
    [(tri? shape)
     (triangle-helper (/ (shape-perimeter shape) 2)
                      (tri-a shape)
                      (tri-b shape)
                      (tri-c shape))]))

(check-expect (shape-area (make-rect 4 7)) 28)
(check-within (shape-area (make-circ 3)) (* 9 pi) 0.00001)
(check-within (shape-area (make-tri 3 4 5)) 6 0.00001)


; triangle-helper : Number Number Number Number -> Number
; Computes the area of a triangle with sides a, b, and c and
; perimeter (* 2 p/2).
; PRECONDITION: (= p/2 (/ (+ a b c) 2))
;
; Strategy: domain knowledge
(define (triangle-helper p/2 a b c)
  (sqrt (* p/2 (- p/2 a) (- p/2 b) (- p/2 c))))


;                                                              
;                                                              
;                                                              
;                                                              
;   ;;;;;;                           ;;                ;;;;;   
;   ;;   ;;                          ;;               ;    ;;  
;   ;;    ;;                         ;;                     ;; 
;   ;;    ;;    ;;;;;     ;;  ;;   ;;;;;;;                  ;; 
;   ;;    ;;   ;    ;;    ;;;;  ;    ;;                    ;;  
;   ;;   ;;         ;;    ;;;        ;;                 ;;;    
;   ;;;;;;      ;;;;;;    ;;         ;;                    ;;  
;   ;;        ;;;   ;;    ;;         ;;                     ;; 
;   ;;        ;;    ;;    ;;         ;;                     ;; 
;   ;;        ;;    ;;    ;;         ;;                     ;; 
;   ;;        ;;   ;;;    ;;         ;;               ;    ;;  
;   ;;         ;;;; ;;    ;;          ;;;;             ;;;;;   
;                                                              
;                                                              
;                                                              
;                                                              

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; A Countdown Timer ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Data Definitions ;;;

;; Constructor:
;;   make-hms   -- (make-hms _ _ _)
;; Predicate:
;;   hms?       -- (hms? _)
;; Selectors:
;;   hms-hr     -- (hms-hr _)
;;   hms-min    -- (hms-min _)
;;   hms-sec    -- (hms-sec _)

; A CDT is (make-hms Nat Nat Nat)
(define-struct hms (hr min sec))
; interp. hours, minutes, and seconds remaining

;; Template for CDT
#;
(define (process-cdt t ...)
  ... (hms-hr t) ...
  ... (hms-min t) ...
  ... (hms-sec t) ...)

; A World is a CDT


;;; Constants ;;;

(define TEXT-SIZE 60)
(define TEXT-COLOR "red")
(define WIDTH 300)
(define HEIGHT 100)
(define MARGIN 10)
(define WORLD0 (make-hms 3 0 0))


;;; Functions ;;;

; decr : CDT -> CDT
; Decrements the timer by one second.
;
; Examples:
;   (decr <1:10:36>)  =>  <1:10:35>
;   (decr <1:10:00>)  =>  <1:09:59>
;   (decr <1:00:00>)  =>  <1:59:59>
;   (decr <0:00:00>)  =>  <0:00:00>

; Strategy: decision tree
(define (decr t)
  (cond
    [(not (zero? (hms-sec t)))
     (make-hms (hms-hr t) (hms-min t) (sub1 (hms-sec t)))]
    [(not (zero? (hms-min t)))
     (make-hms (hms-hr t) (sub1 (hms-min t)) 59)]
    [(not (zero? (hms-hr t)))
     (make-hms (sub1 (hms-hr t)) 59 59)]
    [else
     (make-hms 0 0 0)]))

(check-expect (decr (make-hms 1 10 36))    (make-hms 1 10 35))
(check-expect (decr (make-hms 1 10  0))    (make-hms 1  9 59))
(check-expect (decr (make-hms 1  0  0))    (make-hms 0 59 59))
(check-expect (decr (make-hms 0  0  0))    (make-hms 0  0  0))


;; [alternate approach]
; A CDT* is a Natural

; decr* : CDT* -> CDT*
; Decrements the timer by one second.
;
; Examples:
;   (decr* <1:10:36>)  =>  <1:10:35>
;   (decr* <1:10:00>)  =>  <1:09:59>
;   (decr* <1:00:00>)  =>  <1:59:59>
;   (decr* <0:00:00>)  =>  <0:00:00>

; Strategy: function composition
(define (decr* t)
  (max 0 (sub1 t)))

(check-expect (decr* 15) 14)
(check-expect (decr* 0)  0)

;; [end alternate approach]


; draw-timer : CDT -> Scene
; Renders the timer

; Examples:
;  - <3:30:46> should display as "3:30:46"
;  - <1:10:06> should display as "1:10:06"
;  - <0:00:00> should display as "0:00:00"

; Strategy: function composition
(define (draw-timer t)
  (text->scene (timer->text t)))

(check-expect (draw-timer (make-hms 1 10 6))
              (overlay
               (text "1:10:06" TEXT-SIZE TEXT-COLOR)
               (empty-scene WIDTH HEIGHT)))

; text->scene : String -> Scene
; Renders the text of the timer into a scene.
;
; Examples:
;  - (text->scene "4:30:12") => "4:30:12" centered in the scene
;  - (text->scene "hello") => "hello" centered in the scene

; Strategy: function composition
(define (text->scene s)
  (overlay (text s TEXT-SIZE TEXT-COLOR)
           (empty-scene WIDTH HEIGHT)))

(check-expect (text->scene "4:30:12")
              (overlay (text "4:30:12" TEXT-SIZE TEXT-COLOR)
                       (empty-scene WIDTH HEIGHT)))
(check-expect (text->scene "hello")
              (overlay (text "hello" TEXT-SIZE TEXT-COLOR)
                       (empty-scene WIDTH HEIGHT)))


; timer->text : CDT -> String
; Displays a count down timer as a string

; Examples:
(check-expect (timer->text (make-hms 3 0 0))
              "3:00:00")
(check-expect (timer->text (make-hms 1 31 45))
              "1:31:45")

; Strategy: function composition
(define (timer->text t)
  (string-append
   (number->string (hms-hr t))
   ":"
   (pad-with-0 (number->string (hms-min t)))
   ":"
   (pad-with-0 (number->string (hms-sec t)))))



; pad-with-0 : String -> String
; Add a 0 on the left of a 1 character string, leaving longer unchanged

; Examples:
(check-expect (pad-with-0 "4")   "04")
(check-expect (pad-with-0 "45")  "45")
(check-expect (pad-with-0 "04")  "04")
(check-expect (pad-with-0 "236") "236")
(check-expect (pad-with-0 "0")   "00")

; Strategy: decision tree
(define (pad-with-0 str)
  (cond
    [(= (string-length str) 1) (string-append "0" str)]
    [else                      str]))


#;
(big-bang WORLD0
  [on-tick decr 1]
  [on-draw draw-timer])

;                                                              
;                                                              
;                                                              
;                                                              
;   ;;;;;;                           ;;                    ;;  
;   ;;   ;;                          ;;                   ;;;  
;   ;;    ;;                         ;;                  ;;;;  
;   ;;    ;;    ;;;;;     ;;  ;;   ;;;;;;;               ; ;;  
;   ;;    ;;   ;    ;;    ;;;;  ;    ;;                 ;  ;;  
;   ;;   ;;         ;;    ;;;        ;;                ;;  ;;  
;   ;;;;;;      ;;;;;;    ;;         ;;                ;   ;;  
;   ;;        ;;;   ;;    ;;         ;;               ;    ;;  
;   ;;        ;;    ;;    ;;         ;;               ;;;;;;;;;
;   ;;        ;;    ;;    ;;         ;;                    ;;  
;   ;;        ;;   ;;;    ;;         ;;                    ;;  
;   ;;         ;;;; ;;    ;;          ;;;;                 ;;  
;                                                              
;                                                              
;                                                              
;                                                              

;;; Data Definitions ;;;

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

;; Template for FCDT
#;
(define (process-fcdt t ...)
  (cond
    [(running? t) ... (running-timer t) ...]
    [(frozen? t)  ... (frozen-timer t) ...
                  ... (frozen-record t) ...]
    [(frozen2? t) ... (frozen2-timer t) ...
                  ... (frozen-record1 t) ...
                  ... (frozen-record2 t) ...]))


;;; Functions ;;;

; update-fcdt : FCDT -> FCDT
; Decrements a freezable cdt by one second

; Examples:
;  - (make-running <1:23:08>) => (make-running <1:23:07>)
;  - (make-frozen <1:23:08> <1:23:45>) => (make-frozen <1:23:07> <1:23:45>)

; Strategy: struct. decomp.
(define (update-fcdt t)
  (cond
    [(running? t) (make-running (decr (running-timer t)))]
    [(frozen? t)  (make-frozen (decr (frozen-timer t))
                               (frozen-record t))]
    [(frozen2? t)  (make-frozen2 (decr (frozen2-timer t))
                                 (frozen2-record1 t)
                                 (frozen2-record2 t))]))

(check-expect (update-fcdt (make-running (make-hms 1 23 8)))
              (make-running (make-hms 1 23 7)))
(check-expect (update-fcdt (make-frozen (make-hms 1 23 8) (make-hms 1 24 0)))
              (make-frozen (make-hms 1 23 7) (make-hms 1 24 0)))
(check-expect (update-fcdt (make-frozen2 (make-hms 1 23 8)
                                         (make-hms 1 23 30)
                                         (make-hms 1 24 0)))
              (make-frozen2 (make-hms 1 23 7)
                            (make-hms 1 23 30)
                            (make-hms 1 24 0)))


; handle-keys : FCDT KeyEvt -> FCDT
; Freezes/thaws the timer on spacebar

; Examples:
;  - if key is " ", (make-running <1:23:08>)
;       => (make-frozen <1:23:08> <1:23:08>)
;  - if key is " ", (make-frozen <1:23:08> <1:23:45>)
;       => (make-frozen2 <1:23:08> <1:23:08> <1:23:45>)
;  - if key is " ", (make-frozen2 <1:23:08> <1:23:45> <5:33:17>)
;       => (make-frozen2 <1:23:08> <1:23:08> <1:23:45>)
;  - if key is anything else, no change

; Strategy: struct. decomp.
(define (handle-keys t ke)
  (cond
    [(key=? ke " ") (toggle-fcdt t)]
    [else           t]))

(check-expect (handle-keys (make-running (make-hms 1 23 8)) " ")
              (make-frozen (make-hms 1 23 8) (make-hms 1 23 8)))
(check-expect (handle-keys (make-frozen (make-hms 1 23 8) (make-hms 2 23 8))
                           " ")
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 2 23 8)))
(check-expect (handle-keys (make-frozen2 (make-hms 1 23 8)
                                         (make-hms 2 23 8)
                                         (make-hms 5 23 8))
                           " ")
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 2 23 8)))
(check-expect (handle-keys (make-running (make-hms 1 23 8)) "m")
              (make-running (make-hms 1 23 8)))


; toggle-fcdt : FCDT -> FCDT
; Freezes/thaws a timer.

; Examples:
(check-expect (toggle-fcdt
               (make-running (make-hms 1 23 8)))
              (make-frozen (make-hms 1 23 8) (make-hms 1 23 8)))
(check-expect (toggle-fcdt
               (make-frozen (make-hms 1 23 8) (make-hms 7 0 2)))
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 7 0 2)))
(check-expect (toggle-fcdt
               (make-frozen2 (make-hms 1 23 8) (make-hms 4 59 0) (make-hms 7 0 2)))
              (make-frozen2 (make-hms 1 23 8) (make-hms 1 23 8) (make-hms 4 59 0)))


; Strategy: struct. decomp.
(define (toggle-fcdt t)
  (cond
    [(running? t)
     (make-frozen (running-timer t) (running-timer t))]
    [(frozen? t)
     (make-frozen2 (frozen-timer t) (frozen-timer t) (frozen-record t))]
    [(frozen2? t)
     (make-frozen2 (frozen2-timer t) (frozen2-timer t) (frozen2-record1 t))]))


; draw-fcdt : FCDT -> Scene
; To render the state of the FCDT.
;
; Examples:
;  - (make-running <1:10:06>) => scene with "1:10:06"
;  - (make-frozen <1:10:06> <1:13:45>) => scene with "1:10:06" and "1:13:45"

; Strategy: struct. decomp.
(define (draw-fcdt t)
  (cond
    [(running? t) (beside (draw-timer (running-timer t))
                          (empty-scene WIDTH HEIGHT)
                          (empty-scene WIDTH HEIGHT))]
    [(frozen? t)  (beside (draw-timer (frozen-timer t))
                          (draw-timer (frozen-record t))
                          (empty-scene WIDTH HEIGHT))]
    [(frozen2? t)  (beside (draw-timer (frozen2-timer t))
                           (draw-timer (frozen2-record1 t))
                           (draw-timer (frozen2-record2 t)))]))

(check-expect (draw-fcdt (make-running (make-hms 1 10 6)))
              (beside (text->scene "1:10:06")
                      (empty-scene WIDTH HEIGHT)
                      (empty-scene WIDTH HEIGHT)))
(check-expect (draw-fcdt (make-frozen (make-hms 0 0 30) (make-hms 1 10 6)))
              (beside (text->scene "0:00:30")
                      (text->scene "1:10:06")
                      (empty-scene WIDTH HEIGHT)))
(check-expect (draw-fcdt (make-frozen2 (make-hms 0 0 0)
                                       (make-hms 0 0 30)
                                       (make-hms 1 10 6)))
              (beside (text->scene "0:00:00")
                      (text->scene "0:00:30")
                      (text->scene "1:10:06")))


#;
(big-bang (make-running WORLD0)
  [on-tick update-fcdt 1]
  [on-draw draw-fcdt]
  [on-key handle-keys])
