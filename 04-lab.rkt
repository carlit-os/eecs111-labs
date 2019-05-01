;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 04-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Basics ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;z

; Discussion 0. What is the syntax of a function signature?
; Which step in the design recipe does the signature follow from?
; What does the signature of functions tell you?




; Discussion 1a. What is a synonym data definition? How do you define a
; synonym data definition?




; Discussion 1b. What is an enumeration data definition?
; What is the syntax of an enumeration data definition and
; how does one write the template?



; Discussion 1c. What is a structure data definition?
; What is the syntax of an structure data definition and
; how does one write the template?
;
; What is the name of the constructor, predicate and
; selectors of a struct?




; Discussion 1d. What is an itemization data definition?
; What is the syntax of an itemization data definition and
; how to write a template?



; Disucssion 1e. (_NOT_ in the scope of exam 1 but is important)
; How do you write the template for an itemization data definition
; if it is recursive?
;
; Please provide the constructor, predicate, and selectors for the Alpaca
; struct below, then give the template for processing the Alpaca struct,
; defined below.

; An Alpaca is one of:
; - (make-alpaca String Sex DoB Color Alpaca Alpaca)
; - "unknown"
(define-struct alpaca [name sex dob color sire dam])

; A Sex is one of:
; - "female"
; - "male"

; A DoB is (make-date Year Month Day)
;   where
; Year is an Integer in [1900, 2019]
; Month is an Integer in [1, 12]
; Day is an Integer in [1, 31]
(define-struct date [year month day])


