;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 05-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Basics ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;z

; Exercise 0. What is the syntax of a function signature?
; Which step in the design recipe does the signature follow from?
; What does the signature of functions tell you?

#|
Syntax:

    <function-name> : <Data_1> <Data_2> ... <Data_n> -> <Data_result>

The signatures, which is the second step of the design recipe, follows
from the first step, which is the problem analysis. After analyzing
the data we need and what data the function will be working on, we
will know what <Data_i>s should be.

The signature serves as a contract between the user and the provider
of <function-name>.

To the user, this signature _requires_ that the arguments used to call
<function-name> must be the values in <Data_1> ... <Data_n> and
_ensures_ that the call will results in a value in <Data_result>

To the provider, this signature _ensures_ that all arguments that the
function receives will be values in <Data_1> ... <Data_n> and therefore
the function does not need to check for values outside this range. This
signature also _requires_ that the function returns a value that is
a <Data_reuslt>.
|#




; Exercise 1a. What is a synonym data definition? How do you define a synonym
; data definition?




; Exercise 1b. What is an enumeration data definition?
; What is the syntax of an enumeration data definition and
; how do you write a template for one?




; Exercise 1c. What is a structure data definition?
; What is the syntax of a structure data definition and
; how do you write a template for one?
;
; What are the names of the constructor, predicate and
; selectors of a struct?




; Exercise 1d. What is an itemization data definition?
; What is the syntax of an itemization data definition and
; how do you write a template for one?




; Exercise 1e. (_NOT_ in the scope of exam 1 but is important)
; How do you write the template for an itemization data definition
; if it is recursive?
;
; Please give the template for processing Alpaca, defined below.

; A Sex is one of:
; - "female"
; - "male"

; A DoB is (make-date Year Month Day)
;   where
; Year is an Integer in [1900, 2017]
; Month is an Integer in [1, 12]
; Day is an Integer in [1, 31]
(define-struct date [year month day])

; An Alpaca is one of:
; - (make-alpaca String Sex DoB Color Alpaca Alpaca)
; - "unknown"
(define-struct alpaca [name sex dob color sire dam])




; Exercise 2. Please design a data definition, LoC, that contains an arbitrary
; large number of class records. Give the template for processing LoC.

; A Quarter is one of
; - "Fall"
; - "Winter"
; - "Spring"

; A Class is a structure (make-class Number Number Quarter Number String)
(define-struct class (no units quarter year name))
; interp. A (make-class no unt qtr yr name) is a class with class no `no`,
; name `name` and has `unt` units in the `qtr` quater of year `yr`.
;
; Examples
(define EECS111
  (make-class 111 3.0 "Fall" 2017 "Fundamentals of Computer Programming I"))

(define EECS211
  (make-class 211 3.0 "Winter" 2018 "Fundamentals of Computer Programming II"))

(define EECS213
  (make-class 213 3.0 "Spring" 2018 "Introduction to Computer Systems"))

#| [YOUR CODE HERE] |#




; Exercise 3. Design a function select-name-from-db : LoC -> LoS that takes a
; LoC and returns the name of all courses. For the definition of LoS, see
; course note 14-abstraction.rkt.

#| [YOUR CODE HERE] |#




; Exercise 4. Design a function select-from-db-where-year-is : LoC Number -> LoC
; that takes a LoC, a year and returns the classes in LoC with the specified
; year.

#| [YOUR CODE HERE] |#




; Exercise 5. Design a function select-name-from-db-where-year-is : LoC Number
; -> LoS that returns the name of all courses with the specified year.

#| [YOUR CODE HERE] |#




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Advanced ;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 6. Complete the design of first* and rest* Exercise 176.
; http://www.htdp.org/2018-01-06/Book/part_two.html#(counter._(exercise._ex~3atranspose))
;
; Hint. What data type does `first*` and `rest*` operate on, in the `else`
; clause of `transpose`? Why isn't it just `Matrix` and `Row`?
;
; After finishing `first*` and `rest*`, `transpose` should work.

#| [YOUR CODE HERE] |#




; Exercise 7. Design a function that sorts a list of numbers in descending
; order (This algorithm is called insertion sort.)
;
; Ref sol:
; http://www.htdp.org/2018-01-06/Book/part_two.html#(part._sec~3asort.I)

#| [YOUR CODE HERE] |#
