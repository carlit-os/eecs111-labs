;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-08-itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; A CDT is (make-hms Nat Nat Nat)
(define-struct hms (hr min sec))
; interp. if `t` is a CDT then the number of seconds remaining is:
; (+ (* 3600 (hms-hr t)) -- hours
;    (* 60 (hms-min t))  -- minutes
;    (hms-sec t))        -- seconds

; process-cdt : CDT ... -> ...
; Template for CDT.
#;
(define (process-cdt t ...)
  ... (hms-hr t) ...
  ... (hms-min t) ...
  ... (hms-sec t) ...)

;;; Data examples ;;;

(define EX-CDT-0  (make-hms 1 10 43))
(define EX-CDT-7  (make-hms 1 10 36))

;;; Constants ;;;

(define WIDTH       300)
(define HEIGHT      100)
(define MARGIN      10)
(define TEXT-SIZE   60)
(define TEXT-COLOR  "red")
(define WORLD0      (make-hms 3 0 0))


;;; Functions ;;;

; decr : CDT -> CDT
; Decrements the timer by one second.
;
; Examples:
;   (decr <1:10:36>)  =>  <1:10:35>
;   (decr <1:10:00>)  =>  <1:09:59>
;   (decr <1:00:00>)  =>  <1:59:59>
;   (decr <0:00:00>)  =>  <0:00:00>
;
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


; draw-timer : CDT -> Image
; Renders the timer.
;
; Examples:
;  - <3:30:46> should display as "3:30:46"
;  - <1:10:06> should display as "1:10:06"
;  - <0:00:00> should display as "0:00:00"
;
; Strategy: function composition
(define (cdt-draw t)
  (text->scene (timer->text t)))

(check-expect (cdt-draw (make-hms 1 10 6))
              (overlay
               (text "1:10:06" TEXT-SIZE TEXT-COLOR)
               (empty-scene WIDTH HEIGHT)))


; text->scene : String -> Image
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


; timer->text : CDT -> String
; Formats a countdown timer as a string
;
; Examples:
(check-expect (timer->text (make-hms 3 0 0))
              "3:00:00")
(check-expect (timer->text (make-hms 1 31 45))
              "1:31:45")
;
; Strategy: struct decomp
(define (timer->text t)
  (string-append
   (number->string (hms-hr t))
   ":"
   (pad/to/with (number->string (hms-min t)) 2 "0")
   ":"
   (pad/to/with (number->string (hms-sec t)) 2 "0")))


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

; cdt-start : CDT -> CDT
; Starts the counting timer at the given time.
; To use, uncomment and call like this: (cdt-start WORLD0)
#;
(define (cdt-start time0)
  (big-bang time0
    [to-draw draw-timer]
    [on-tick decr 1]))


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

; An FCDT is one of:
;  - (make-running CDT)
;  - (make-frozen CDT CDT)
;
; interp. if `t` is an FCDT then one of:
;  - if (running? t) then (running-timer t) is the current timer, or
;  - if (frozen? t) then both of:
;     - (frozen-hidden t) is the hidden timer (still running), and
;     - (frozen-visible t) is the displayed timer (frozen).
(define-struct running (timer))
(define-struct frozen (hidden visible))

; process-fcdt : FCDT ... -> ...
; Template for FCDT.
#;
(define (process-fcdt t ...)
  (cond
    [(running? t)  ... (running-timer t) ...]
    [(frozen? t)   ... (frozen-hidden t) ...
                   ... (frozen-visible t) ...]))




; Start out running:
(define EX-FCDT/1 (make-running EX-CDT-0))
; Hitting space splits into a hidden CDT that continues to
; run and a visible one that's paused:
(define EX-FCDT/2 (make-frozen EX-CDT-0 EX-CDT-0))
; Seven seconds later the hidden CDT has advanced but the visible
; CDT has not:
(define EX-FCDT/3 (make-frozen EX-CDT-7 EX-CDT-0))
; Hitting space again discards the visible, frozen CDT and retains
; the CDT that continued to run while hidden:
(define EX-FCDT/4 (make-running EX-CDT-7))

;;; Functions ;;;


; fcdt-visible : FCDT -> CDT
; Extracts the CDT to display.
;
; Examples:
(check-expect (fcdt-visible (make-running EX-CDT-0))
              EX-CDT-0)
(check-expect (fcdt-visible (make-frozen EX-CDT-7 EX-CDT-0))
              EX-CDT-0)
;
; Strategy: struct decomp
(define (fcdt-visible t)
  (cond
    [(running? t)   (running-timer t)]
    [else           (frozen-visible t)]))


; fcdt-running : FCDT -> CDT
; Extracts the CDT that is current running.
;
; Examples:
(check-expect (fcdt-running (make-running EX-CDT-0))
              EX-CDT-0)
(check-expect (fcdt-running (make-frozen EX-CDT-7 EX-CDT-0))
              EX-CDT-7)
;
; Strategy: struct decomp
(define (fcdt-running t)
  (cond
    [(running? t)   (running-timer t)]
    [else           (frozen-hidden t)]))


; fcdt-replace-running : FCDT CDT -> FCDT
; Replaces the running timer in an FCDT with the given CDT.
;
; Examples:
(check-expect (fcdt-replace-running (make-running EX-CDT-0)
                                    (decr EX-CDT-0))
              (make-running (decr EX-CDT-0)))
(check-expect (fcdt-replace-running (make-frozen EX-CDT-7 EX-CDT-0)
                                    (decr EX-CDT-7))
              (make-frozen (decr EX-CDT-7) EX-CDT-0))
;
; Strategy: struct decomp
(define (fcdt-replace-running ft t)
  (cond
    [(running? ft) (make-running t)]
    [else          (make-frozen t (frozen-visible ft))]))


; update-fcdt : FCDT -> FCDT
; Decrements a freezable CDT by one second
;
; Examples:
;  - (make-running <1:23:08>) => (make-running <1:23:07>)
;  - (make-frozen <1:23:08> <1:23:45>) => (make-frozen <1:23:07> <1:23:45>)

; Strategy: function composition
(define (update-fcdt t)
  (fcdt-replace-running t (decr (fcdt-running t))))

(check-expect (update-fcdt (make-running (make-hms 1 23 8)))
              (make-running (make-hms 1 23 7)))
(check-expect (update-fcdt (make-frozen (make-hms 1 23 8) (make-hms 1 24 0)))
              (make-frozen (make-hms 1 23 7) (make-hms 1 24 0)))


; handle-keys : FCDT KeyEvent -> FCDT
; Freezes/thaws the timer on spacebar

; Examples:
;  - if key is " ", (make-running <1:23:08>)
;       => (make-frozen <1:23:08> <1:23:08>)
;  - if key is " ", (make-frozen <1:23:08> <1:23:45>)
;       => (make-running <1:23:08>)
;  - if key is anything else, no change
;
; Strategy: struct. decomp.
(define (handle-keys t ke)
  (cond
    [(key=? ke " ") (toggle-fcdt t)]
    [else           t]))

(check-expect (handle-keys (make-running (make-hms 1 23 8)) " ")
              (make-frozen (make-hms 1 23 8) (make-hms 1 23 8)))
(check-expect (handle-keys (make-frozen (make-hms 1 23 8) (make-hms 2 23 8))
                           " ")
              (make-running (make-hms 1 23 8)))
(check-expect (handle-keys (make-running (make-hms 1 23 8)) "m")
              (make-running (make-hms 1 23 8)))


; toggle-fcdt : FCDT -> FCDT
; Freezes/thaws a timer.
;
; Examples:
(check-expect (toggle-fcdt (make-running (make-hms 1 23 8)))
              (make-frozen (make-hms 1 23 8) (make-hms 1 23 8)))
(check-expect (toggle-fcdt (make-frozen (make-hms 1 23 8) (make-hms 7 0 2)))
              (make-running (make-hms 1 23 8)))
;
; Strategy: struct. decomp.
(define (toggle-fcdt t)
  (cond
    [(running? t)
     (make-frozen (running-timer t) (running-timer t))]
    [(frozen? t)
     (make-running (frozen-hidden t))]))


; draw-fcdt : FCDT -> Image
; To render the state of the FCDT.
;
; Examples:
;  - (make-running <1:10:06>) => scene with "1:10:06"
;  - (make-frozen <1:13:45> <1:10:06>) => scene with "1:13:45"
;
; Strategy: function composition
(define (fcdt-to-draw t)
  (cdt-draw (fcdt-visible t)))

(check-expect (fcdt-to-draw (make-running (make-hms 1 10 6)))
              (text->scene "1:10:06"))
(check-expect (fcdt-to-draw (make-frozen (make-hms 0 0 30) (make-hms 1 10 6)))
              (text->scene "1:10:06"))


; fcdt-start : CDT -> FCDT
; Starts the freezable counting timer running at the given time.
; To use, uncomment and call like this: (fcdt-start WORLD0)
#;
(define (fcdt-start time0)
  (big-bang (make-running time0)
    [to-draw fcdt-to-draw]
    [on-tick update-fcdt 1]  
    [on-key  handle-keys]))
