;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03-lab-08-itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;; A freezable countdown timer ;;;;;

(require 2htdp/universe)
(require 2htdp/image)



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
(define (draw-timer t)
  (text->scene (timer->text t)))

(check-expect (draw-timer (make-hms 1 10 6))
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

#;
(big-bang WORLD0
  [to-draw draw-timer]
  [on-tick decr 1])

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
                  ... (frozen2-record1 t) ...
                  ... (frozen2-record2 t) ...]))


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
