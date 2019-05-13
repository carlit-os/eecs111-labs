;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 06-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART A : Recursion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 1. Please write the template for each of the following
; data definitions.

; Exercise 1a.
; An List-of-evens is one of
; - '()
; - (cons Number (cons Number List-of-evens))

#;
(define (process-enl enl ...)
  (cond
    [(empty? enl) ...]
    [(and (cons? enl) (cons? (rest enl))) ; there are other ways to write this
     ... (first enl) ...
     ... (first (rest enl)) ...
     ... (process-enl (rest (rest enl)) ...) ...]))

; Exercise 1b.
; A 1Row is one of:
;  – (cons Number '())
;  – (cons Number 1Row)

#;
(define (process-1row 1row ...)
  (cond
    [(empty? (rest 1row))
     ... (first 1row) ...]
    [(cons? (rest 1row))
     ... (first 1row) ...
     ... (process-1row (rest 1row ...)) ...]))


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
;
; select-name-from-db : [List-of Class] -> [List-of String]
; Compute the name of all courses.
;
; select-name-from-db-where-year-is : [List-of Class] Number -> [List-of String]
; Compute the name of all courses with the specified year.

; Exercise 2. Please reformulate the purpose of select-name-from-db in
; terms of '...'.

; select-name-from-db : [List-of Class] -> [List-of String]
; Compute the name of all courses:
; (select-name-from-db
;   (list
;     (make-class no0 units0 quarter0 quarter0 year0 name0)
;     (make-class no1 units1 quarter1 quarter1 year1 name1)
;     ...
;     (make-class nok unitsk quarterk quarterk yeark namek))) =
; (list name0 name1 ... namek)

; The following functions should also be easy to implement:
;
; select-no-from-db : [List-of Class] -> [List-of Number]
; select-units-from-db : [List-of Class] -> [List-of Number]
; select-quarter-from-db : [List-of Class] -> [List-of Quarter]
; select-year-from-db : [List-of Class] -> [List-of Number]

; Exercise 3a. Design a function select-from-db that extracts the specified
; field from a list of courses.

; select-from-db : [Class -> A] [List-of Class] -> [List-of A]
; [YOUR CODE HERE] (purpose)
; Examples.
; - (select-from-db all classes) = classes. Select the entire class data as-is.
; - [YOUR CODE HERE] (more examples)
(define (select-from-db selector loc)
  (cond
    [(empty? loc) '()]
    [(cons? loc) (cons (selector (first loc))
                       (select-from-db selector (rest loc)))]))
(check-expect (select-from-db all CLASSES-EX0) CLASSES-EX0)
(check-expect (select-from-db class-year CLASSES-EX0) (list 2017 2018 2018))

; Exercise 3b. Design a function, where, that produce a function comparing
; whether the specified field of a class satisfies certain condition.
;
; To be precise, where takes three arguments: a selector of class,
; a comparison function, and a value to compare to. `where` will return
; a function that test whether a given class satisfies the given condition.

; where : [Class -> A] [A A -> Boolean] A -> [Class -> Boolean]
; Examples: see tests
(define (where selector compare-to val)
  (local
    [(define (pred? class)
       (compare-to (selector class) val))]
    pred?))

(define CLASS-ALL-EQUAL (where all equal? EECS213))
(check-expect (CLASS-ALL-EQUAL EECS213) #t)
(check-expect (CLASS-ALL-EQUAL EECS111) #f)

(define CLASS-UNIT-<-3 (where class-units < 3))
(check-expect (CLASS-UNIT-<-3 EECS211) #f)

(define CLASS-YEAR-IS-2018 (where class-year = 2018))
(check-expect (CLASS-YEAR-IS-2018 EECS395) #f)
(check-expect (CLASS-YEAR-IS-2018 EECS211) #t)

; Exercise 3c. Design a function select-cond selecting classes that
; satisfy the given condition, as an abstraction of the function
; select-from-db-where-year-is.

; select-cond : [Class -> Boolean] [List-of Class] -> [List-of Class]
; [YOUR CODE HERE] (purpose)
; Examples.
(check-expect (select-cond CLASS-YEAR-IS-2018 CLASSES-EX0)
              (rest CLASSES-EX0))
(check-expect (select-cond (where class-year < 2018) CLASSES-EX0)
              (list (first CLASSES-EX0)))
(check-expect (select-cond (where class-units >= 2) CLASSES-EX0)
              CLASSES-EX0)
(define (select-cond pred? loc)
  (cond
    [(empty? loc) '()]
    [(cons? loc)
     (if (pred? (first loc))
         (cons (first loc) (select-cond pred? (rest loc)))
         (select-cond pred? (rest loc)))]))

; Exercise 4. Design our final function, select, to extract the desired
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
  (select-from-db selector (select-cond pred? loc)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART C : Intermediates ;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 5. Please do Exercise 270.
#|
https://htdp.org/2019-02-24/part_three.html#%28counter
._%28exercise._ex~3abuild-list1%29%29
#(counter._(exercise._ex~3abuild-list1))
|#

; exercise-270-1 : Integer -> [List-of Number]
; (exercise-270-1 n) = (list 0 ... (- n 1))
(check-expect (exercise-270-1 5)
              (list 0 1 2 3 4))
(define (exercise-270-1 n)
  (local [(define (index-as-ith-item m) m)]
    (build-list n index-as-ith-item)))


; exercise-270-2 : Integer -> [List-of Number]
; (exercise-270-2 n) = (list 1 ... n)
(check-expect (exercise-270-2 5)
              (list 1 2 3 4 5))
(define (exercise-270-2 n)
  (local [(define (count-from-1 m) (+ m 1))]
    (build-list n count-from-1)))


; exercise-270-3 : Integer -> [List-of Number]
; (exercise-270-3 n) = (list 1 1/2 ... 1/n)
(check-expect (exercise-270-3 5)
              (list 1 1/2 1/3 1/4 1/5))
(define (exercise-270-3 n)
  (local [(define (reciprocal m) (/ 1 (+ m 1)))]
    (build-list n reciprocal)))


; exercise-270-4 : Integer -> [List-of Number]
; (exercise-270-4 n) = the list of first n even numbers
(check-expect (exercise-270-4 5)
              (list 0 2 4 6 8))
(define (exercise-270-4 n)
  (local [(define (mth-even m) (* m 2))]
    (build-list n mth-even)))


; exercise-270-5 : Integer -> [List-of [List-of Number]]
; (exercise-270-5 n) = create the identity matrix of size n×n
(check-expect (exercise-270-5 4)
              (list (list 1 0 0 0)
                    (list 0 1 0 0)
                    (list 0 0 1 0)
                    (list 0 0 0 1)))
(define (exercise-270-5 n)
  (local [(define (standard-basis-i i)
            (build-list n (delayed= i)))]
    (build-list n standard-basis-i)))
(define (delayed= m)
  (local [(define (is-at-m i)
            (cond [(= m i) 1]
                  [else 0]))]
    is-at-m))


; tabulate : [Number -> Number] Number -> Number
; (tabulate f n) = (list (f n) ... (f 0))
(check-expect (tabulate add1 2)
              (list 3 2 1))
(define (tabulate f n)
  (cond [(= n 0) (list (f 0))]
        [else (cons (f n) (tabulate f (- n 1)))]))
