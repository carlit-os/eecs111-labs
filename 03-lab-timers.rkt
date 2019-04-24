;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-timers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;; TWO TIMERS ;;;;

(require 2htdp/universe)
(require 2htdp/image)

;
;
;
;   ;;;;;;                                              ;;;
;   ;     ;                         ;                 ;;;;;
;   ;      ;                        ;                 ;  ;;
;   ;      ;    ;;;;;     ; ;;;   ;;;;;;                 ;;
;   ;      ;   ;    ;;    ;;   ;    ;                    ;;
;   ;     ;          ;    ;         ;                    ;;
;   ;;;;;;      ;;;;;;    ;         ;                    ;;
;   ;         ;;     ;    ;         ;                    ;;
;   ;         ;      ;    ;         ;                    ;;
;   ;         ;     ;;    ;         ;                    ;;
;   ;         ;;   ;;;    ;         ;                    ;;
;   ;          ;;;;; ;    ;          ;;;               ;;;;;;
;
;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; A Countdown Timer ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A Timer is (make-timer Nat Nat Nat)
(define-struct timer (hr min sec))
; interp. if `t` is a Timer then the number of seconds remaining is:
; (+ (* 3600 (timer-hr t)) -- hours
;    (* 60 (timer-min t))  -- minutes
;    (timer-sec t))        -- seconds
;
; INVARIANT:
;  - 0 ≤ (timer-min t) < 60
;  - 0 ≤ (timer-sec t) < 60


; process-timer : Timer ... -> ...
; Template for Timer.
#;
(define (process-timer t ...)
  ... (timer-hr t) ...
  ... (timer-min t) ...
  ... (timer-sec t) ...)

;;; Data examples ;;;

(define EX-TIMER-0  (make-timer 1 10 43))
(define EX-TIMER-7  (make-timer 1 10 36))

;;; Constants ;;;

(define WIDTH       300)
(define HEIGHT      100)
(define MARGIN      10)
(define TEXT-SIZE   60)
(define TEXT-COLOR  "red")
(define WORLD0      (make-timer 3 0 0))


;;; Functions ;;;

; decr-timer : ???
; Decrements the timer by one second.
;
; Examples:
;   (decr-timer <1:10:36>)  =>  <1:10:35>
;   (decr-timer <1:10:00>)  =>  <1:09:59>
;   (decr-timer <1:00:00>)  =>  <1:59:59>
;   (decr-timer <0:00:00>)  =>  <0:00:00>
;
; Strategy: decision tree
(define (decr-timer t)
  (cond
    [(not (zero? (timer-sec t)))
     (make-timer (timer-hr t) (timer-min t) (sub1 (timer-sec t)))]
    [(not (zero? (timer-min t)))
     (make-timer (timer-hr t) (sub1 (timer-min t)) 59)]
    [(not (zero? (timer-hr t)))
     (make-timer (sub1 (timer-hr t)) 59 59)]
    [else
     (make-timer 0 0 0)]))

(check-expect (decr-timer (make-timer 1 10 36))    (make-timer 1 10 35))
(check-expect (decr-timer (make-timer 1 10  0))    (make-timer 1  9 59))
(check-expect (decr-timer (make-timer 1  0  0))    (make-timer 0 59 59))
(check-expect (decr-timer (make-timer 0  0  0))    (make-timer 0  0  0))


; to-draw-timer : ???
; Renders the timer.
;
; Examples:
;  - <3:30:46> should display as "3:30:46"
;  - <1:10:06> should display as "1:10:06"
;  - <0:00:00> should display as "0:00:00"
;
; Strategy: function composition
(define (timer-draw t)
  (text->scene (timer->text t)))

(check-expect (timer-draw (make-timer 1 10 6))
              (overlay
               (text "1:10:06" TEXT-SIZE TEXT-COLOR)
               (empty-scene WIDTH HEIGHT)))


; text->scene : ???
; Renders the given text in the center of the scene.
;
; Examples:
;  - (text->scene "4:30:12") => "4:30:12" centered in the scene
;  - (text->scene "hello") => "hello" centered in the scene
;
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


; timer->text : Timer -> String
; Formats a countdown timer as a string
;
; Examples:
(check-expect (timer->text (make-timer 3 0 0))
              "3:00:00")
(check-expect (timer->text (make-timer 1 31 45))
              "1:31:45")
;
; Strategy: struct decomp
(define (timer->text t)
  (string-append
   (number->string (timer-hr t))
   ":"
   (pad/to/with (number->string (timer-min t)) 2 "0")
   ":"
   (pad/to/with (number->string (timer-sec t)) 2 "0")))


; pad/to/with : String Natural String -> String
; Pads `str` on the left with sufficient repetitions of `padding` to
; reach length `len`.
;
; Examples:
(check-expect (pad/to/with "4" 2 "0")   "04")
(check-expect (pad/to/with "45" 2 "0")  "45")
(check-expect (pad/to/with "04" 2 "0")  "04")
(check-expect (pad/to/with "236" 2 "0") "236")
(check-expect (pad/to/with "0" 2 "0")   "00")
(check-expect (pad/to/with "5" 5 "*")   "****5")
(check-expect (pad/to/with "5" 6 "*/")  "*/*/*5")
;
; Strategy: function composition
(define (pad/to/with str len padding)
  (string-append (replicate-to
                  (max 0 (- len (string-length str)))
                  padding)
                 str))


; replicate-to : Natural String -> String
; Repeats `s` sufficient times to build a string of length `i`.
;
; Examples:
(check-expect (replicate-to 0 "*") "")
(check-expect (replicate-to 1 "*") "*")
(check-expect (replicate-to 5 "*") "*****")
(check-expect (replicate-to 10 "123") "1231231231")
;
; Strategy: domain knowledge
(define (replicate-to i s)
  (substring
   (replicate (ceiling (/ i (string-length s))) s)
   0 i))

; timer-start : Timer -> Timer
; Starts the counting timer at the given time.
; To use, uncomment and call like this: (timer-start WORLD0)
#;
(define (timer-start time0)
  (big-bang time0
    [to-draw to-draw-timer]
    [on-tick decr-timer 1]))


;
;
;
;   ;;;;;;                                             ;;;;;
;   ;     ;                         ;                 ;;    ;
;   ;      ;                        ;                 ;      ;
;   ;      ;    ;;;;;     ; ;;;   ;;;;;;                     ;
;   ;      ;   ;    ;;    ;;   ;    ;                        ;
;   ;     ;          ;    ;         ;                       ;
;   ;;;;;;      ;;;;;;    ;         ;                      ;
;   ;         ;;     ;    ;         ;                     ;
;   ;         ;      ;    ;         ;                    ;
;   ;         ;     ;;    ;         ;                   ;
;   ;         ;;   ;;;    ;         ;                  ;;
;   ;          ;;;;; ;    ;          ;;;              ;;;;;;;;
;
;
;
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; A Freezable Countdown Timer ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; An FTimer is one of:
;  - (make-running Timer)
;  - (make-frozen Timer Timer)
;
; interp. if `t` is an FTimer then one of:
;  - if (running? t) then (running-timer t) is the current timer, or
;  - if (frozen? t) then both of:
;     - (frozen-hidden t) is the hidden timer (still running), and
;     - (frozen-visible t) is the displayed timer (frozen).
(define-struct running (timer))
(define-struct frozen (hidden visible))

#| YOUR TEMPLATE HERE |#


;; Some example states (with narrative!):

; Start out running:
(define EX-FTIMER/1 (make-running EX-TIMER-0))
; Hitting space splits into a hidden Timer that continues to
; run and a visible one that's paused:
(define EX-FTIMER/2 (make-frozen EX-TIMER-0 EX-TIMER-0))
; Seven seconds later the hidden Timer has advanced but the visible
; Timer has not:
(define EX-FTIMER/3 (make-frozen EX-TIMER-7 EX-TIMER-0))
; Hitting space again discards the visible, frozen Timer and retains
; the Timer that continued to run while hidden:
(define EX-FTIMER/4 (make-running EX-TIMER-7))

;;; Functions ;;;


; ftimer-visible : FTimer -> Timer
; Selects the Timer that should be visible right now.
;
; Examples:
(check-expect (ftimer-visible (make-running EX-TIMER-0))
              EX-TIMER-0)
(check-expect (ftimer-visible (make-frozen EX-TIMER-7 EX-TIMER-0))
              EX-TIMER-0)
;
; Strategy: struct decomp
(define (ftimer-visible t)
  EX-TIMER-0)  ;;; I AM WRONG -- FIX ME ;;;


; ftimer-running : FTimer -> Timer
; Selects the Timer that is running right now.
;
; Examples:
(check-expect (ftimer-running (make-running EX-TIMER-7))
              EX-TIMER-7)
(check-expect (ftimer-running (make-frozen EX-TIMER-7 EX-TIMER-0))
              EX-TIMER-7)
;
; Strategy: struct decomp
(define (ftimer-running t)
  EX-TIMER-7)  ;;; I AM WRONG -- FIX ME ;;;


; ftimer-replace-running : FTimer Timer -> FTimer
; Replaces the running timer in an FTimer with the given Timer.
;
; Examples:
(check-expect (ftimer-replace-running (make-running EX-TIMER-7)
                                    (decr-timer EX-TIMER-7))
              (make-running (decr-timer EX-TIMER-7)))
#|
(check-expect (ftimer-replace-running (make-frozen EX-TIMER-7 EX-TIMER-0)
                                    (decr-timer EX-TIMER-7))
              (make-frozen (decr-timer EX-TIMER-7) EX-TIMER-0))
|#
;
; Strategy: struct decomp
(define (ftimer-replace-running ft t)
  (make-running (decr-timer EX-TIMER-7)))  ;;; I AM WRONG -- FIX ME ;;;


; to-draw-ftimer : FTimer -> Image
; To render the state of the FTimer.
;
; Examples:
;  - (make-running <1:10:06>) => scene with "1:10:06"
;  - (make-frozen <1:13:45> <1:10:06>) => scene with "1:13:45"
;
; Strategy: function composition
(define (to-draw-ftimer t)
  (timer-draw WORLD0))  ;;; I AM WRONG -- FIX ME ;;;


; decr-ftimer : FTimer -> FTimer
; Decrements a freezable timer by one second
;
; Examples:
;  - (make-running <1:23:08>) => (make-running <1:23:07>)
;  - (make-frozen <1:23:08> <1:23:45>) => (make-frozen <1:23:07> <1:23:45>)
;
; Strategy: function composition
(define (decr-ftimer t)
  t)  ;;; I AM WRONG -- FIX ME ;;;

#|
(check-expect (decr-ftimer (make-running (make-timer 1 23 8)))
              (make-running (make-timer 1 23 7)))
(check-expect (decr-ftimer (make-frozen (make-timer 1 23 8)
                                        (make-timer 1 24 0)))
              (make-frozen (make-timer 1 23 7) (make-timer 1 24 0)))
|#


; ftimer-on-key : FTimer KeyEvent -> FTimer
; Freezes/thaws the timer on spacebar

; Examples:
;  - if key is " ", (make-running <1:23:08>)
;       => (make-frozen <1:23:08> <1:23:08>)
;  - if key is " ", (make-frozen <1:23:08> <1:23:45>)
;       => (make-running <1:23:08>)
;  - if key is anything else, no change
;
; Strategy: struct. decomp.
(define (ftimer-on-key t ke)
  (cond
    [(key=? ke " ") (ftimer-toggle t)]
    [else           t]))

(check-expect (ftimer-on-key (make-running (make-timer 1 23 8)) " ")
              (make-frozen (make-timer 1 23 8) (make-timer 1 23 8)))
(check-expect (ftimer-on-key (make-frozen (make-timer 1 23 8)
                                          (make-timer 2 23 8))
                           " ")
              (make-running (make-timer 1 23 8)))
(check-expect (ftimer-on-key (make-running (make-timer 1 23 8)) "m")
              (make-running (make-timer 1 23 8)))


; ftimer-toggle : FTimer -> FTimer
; Freezes/thaws a timer.
;
; Examples:
(check-expect (ftimer-toggle (make-running (make-timer 1 23 8)))
              (make-frozen (make-timer 1 23 8) (make-timer 1 23 8)))
(check-expect (ftimer-toggle (make-frozen (make-timer 1 23 8)
                                          (make-timer 7 0 2)))
              (make-running (make-timer 1 23 8)))
;
; Strategy: struct. decomp.
(define (ftimer-toggle t)
  (cond
    [(running? t)
     (make-frozen (running-timer t) (running-timer t))]
    [(frozen? t)
     (make-running (frozen-hidden t))]))

#|
(check-expect (to-draw-ftimer (make-running (make-timer 1 10 6)))
              (text->scene "1:10:06"))
(check-expect (to-draw-ftimer (make-frozen (make-timer 0 0 30)
                                           (make-timer 1 10 6)))
              (text->scene "1:10:06"))
|#


; ftimer-start : Timer -> FTimer
; Starts the freezable counting timer running at the given time.
; To use, uncomment and call like this: (ftimer-start WORLD0)
#;
(define (ftimer-start time0)
  (big-bang (make-running time0)
    [to-draw to-draw-ftimer]
    [on-tick decr-ftimer 1]
    [on-key  ftimer-on-key]))

