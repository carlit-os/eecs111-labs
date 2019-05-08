;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 05-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Basics ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 1.
; How do you write the template for an itemization data definition
; if it is recursive?
;
; Please give the template for processing AlpacaTree defined below.

; An AlpacaTree is one of:
; - (make-alpaca String Sex DoB Color AlpacaTree AlpacaTree)
; - "unknown"
(define-struct alpaca [name sex dob color sire dam])
;
; where
;
; A Sex is one of:
; - "female"
; - "male"
; - "unlisted"
;
; A DoB is (make-date Year Month Day)
;   where
; Year is an Integer in [1900, 2019]
; Month is an Integer in [1, 12]
; Day is an Integer in [1, 31]
(define-struct date [year month day])


; Exercise 2. Please design a data definition, LoC, that contains an arbitrary
; number of class records. Give the template for processing LoC.

; A Class is a structure (make-class Number Number Quarter Number String)
(define-struct class (no units quarter year name))
; interp. A (make-class no unt qtr yr name) is a class with class no `no`,
; name `name` and has `unt` units in the `qtr` quater of year `yr`.
;
; where
;
; A Quarter is one of
; - "Fall"
; - "Winter"
; - "Spring"

;; Examples

(define EECS111
  (make-class 111 3.0 "Spring" 2019 "Fundamentals of Computer Programming I"))
(define EECS211
  (make-class 211 3.0 "Fall" 2019 "Fundamentals of Computer Programming II"))
(define EECS213
  (make-class 213 3.0 "Winter" 2020 "Introduction to Computer Systems"))

#| [YOUR CODE HERE] |#




; Exercise 3. First define the class of data LoS to be a list of
; strings. Then design a function select-name-from-db : LoC -> LoS that
; takes a LoC and returns the names of all courses.

#| [YOUR CODE HERE] |#




; Exercise 4. Design a function
;
;     select-from-db-where-year-is : LoC Number -> LoC
;
; that takes a LoC, a year and returns the classes in LoC with the
; specified year.

#| [YOUR CODE HERE] |#




; Exercise 5. Design a function
;
;     select-name-from-db-where-year-is : LoC Number -> LoS
;
; that returns the names of all courses with the specified year.

#| [YOUR CODE HERE] |#




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Advanced ;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 6. Complete the design of first* and rest* HtDP/2e Exercise 176:
; https://bit.ly/2VpNY8P
;
; Hint. What data type does `first*` and `rest*` operate on, in the `else`
; clause of `transpose`? Why isn't it just `Matrix` and `Row`?
;
; After finishing `first*` and `rest*`, `transpose` should work.

#| [YOUR CODE HERE] |#




; Exercise 7. Design a function that sorts a list of numbers in
; descending order. You can do this following the list template, with a
; helper that also follows the list template in order to insert one
; number in the correct position into a list that's already sorted.
; (This algorithm is called insertion sort.)
;
; Reference solution: https://bit.ly/2PTIBbG

#| [YOUR CODE HERE] |#

