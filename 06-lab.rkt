;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 06-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART A : Recursion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 1. Please write the template for each of the following
; data definitions.

; Exercise 1a.
; An List-of-evens is one of
; - '()
; - (cons Number (cons Number List-of-evens))

#| [YOUR CODE HERE] |#




; Exercise 1b.
; A 1Row is one of:
;  – (cons Number '())
;  – (cons Number 1Row)

#| [YOUR CODE HERE] |#




;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART B : Abstractions ;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(define EECS395
  (make-class 395 3.0 "Fall" 2017 "Code Analysis and Transformation"))

; An example of [List-of Class]
(define CLASSES-EX0
  (list EECS111 EECS211 EECS213))

; all : Class -> Class
; Returns all fields in a Class as-is.
; Examples.
(check-expect (all EECS111) EECS111)
(check-expect (all EECS211) EECS211)
(check-expect (all EECS395) EECS395)
(define (all course)
  course)

; From Lab 5, the following function should've been finished:
;
; select-from-db-where-year-is : [List-of Class] Number -> [List-of Class]
; Compute the classes in given class list with the specified year.
(define (select-from-db-where-year-is loc year)
  (cond
    [(empty? loc) '()]
    [(cons? loc)
     (if (equal? (class-year (first loc)) year)
         (cons (first loc)
               (select-from-db-where-year-is (rest loc) year))
         (select-from-db-where-year-is (rest loc) year))]))

;
; select-name-from-db : [List-of Class] -> [List-of String]
; Compute the name of all courses.
(define (select-name-from-db loc)
  (cond
    [(empty? loc) '()]
    [(cons? loc) (cons (class-name (first loc))
                       (select-name-from-db (rest loc)))]))

;
; select-name-from-db-where-year-is : [List-of Class] Number -> [List-of String]
; Compute the name of all courses with the specified year.

(define (select-name-from-db-where-year-is loc year)
  (select-name-from-db
   (select-from-db-where-year-is loc year)))

; Exercise 2. Please reformulate the purpose of select-name-from-db in
; terms of '...'.

#| [YOUR CODE HERE] |#




; The following functions should also be easy to implement:
;
; select-no-from-db : [List-of Class] -> [List-of Number]
; select-units-from-db : [List-of Class] -> [List-of Number]
; select-quarter-from-db : [List-of Class] -> [List-of Quarter]
; select-year-from-db : [List-of Class] -> [List-of Number]

; Exercise 3a. Design a function select-from-db that extracts the specified
; field from a list of courses.

; select-from-db : [Class -> A] [List-of Class] -> [List-of A]
#| [YOUR CODE HERE] |# (purpose)
; Examples.
; - (select-from-db all classes) = classes. Select the entire class data as-is.
; - [YOUR CODE HERE] (more examples)
(define (select-from-db selector loc)
  ...)




; Exercise 3b. Design a function, where, that returns a function comparing
; whether the specified field of a class satisfies a certain condition.
;
; To be precise, where takes three arguments: a class selector
; (i.e. class-name), a comparison function, and a value to compare to.
; `where` will return a function that tests whether a given class satisfies
; the given condition.

; where : [Class -> A] [A A -> Boolean] A -> [Class -> Boolean]
; Examples: see tests
(define (where selector compare-to val)
  ...)

(define CLASS-ALL-EQUAL (where all equal? EECS213))
(check-expect (CLASS-ALL-EQUAL EECS213) #t)
(check-expect (CLASS-ALL-EQUAL EECS111) #f)

(define CLASS-UNIT-<-3 (where class-units < 3))
(check-expect (CLASS-UNIT-<-3 EECS211) #f)

(define CLASS-YEAR-IS-2018 (where class-year = 2018))
(check-expect (CLASS-YEAR-IS-2018 EECS395) #f)
(check-expect (CLASS-YEAR-IS-2018 EECS211) #t)




; Exercise 3c. Design a function select-cond, which returns classes that
; satisfy the given condition, as an abstraction of the function
; select-from-db-where-year-is.

; select-cond : [Class -> Boolean] [List-of Class] -> [List-of Class]
#| [YOUR CODE HERE] |# (purpose)
; Examples.
(check-expect (select-cond CLASS-YEAR-IS-2018 CLASSES-EX0)
              (rest CLASSES-EX0))
(check-expect (select-cond (where class-year < 2018) CLASSES-EX0)
              (list (first CLASSES-EX0)))
(check-expect (select-cond (where class-units >= 2) CLASSES-EX0)
              CLASSES-EX0)
(define (select-cond pred? loc)
  ...)




; Exercise 4. Design our final function, select, that extracts the desired
; field from all classes that satisfy the given condition. This is our
; 'database query' function.

; select : [Class -> A] [List-of Class] [Class -> Boolean] -> [List-of A]
#| [YOUR CODE HERE] (purpose) |#
; Examples
(check-expect (select class-year CLASSES-EX0 (where class-units >= 2))
              (list 2017 2018 2018))
(check-expect (select all CLASSES-EX0 (where class-quarter equal? "Winter"))
              (list (second CLASSES-EX0)))
#| [YOUR CODE HERE] (more examples) |#
(define (select selector loc pred?)
  ...)




;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART C : Intermediates ;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 5. Please do Exercise 270.
#|
https://htdp.org/2019-02-24/part_three.html#%28counter._%28exercise._ex~3abuild-list1%29%29#(counter._(exercise._ex~3abuild-list1))
|#
