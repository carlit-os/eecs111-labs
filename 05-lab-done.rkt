;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 05-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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
;
; A DoB is (make-date Year Month Day)
;   where
; Year is an Integer in [1900, 2019]
; Month is an Integer in [1, 12]
; Day is an Integer in [1, 31]
(define-struct date [year month day])

; ============================= step 1 =============================
#;
(define (process-alpaca-tree alp ...)
  (cond
    [...
     ...]
    [...
     ...]))

; ============================= step 2 =============================
#;
(define (process-alpaca-tree alp ...)
  (cond
    [(alpaca? alp)
     ...]
    [else
     ...]))

; ============================= step 3 =============================
#;
(define (process-alpaca-tree alp ...)
  (cond
    [(alpaca? alp)
     ... (alpaca-name alp) ...
     ... (alpaca-sex alp) ...
     ... (alpaca-dob alp) ...
     ... (alpaca-color alp) ...
     ... (alpaca-sire alp) ...    ;; <= note: this is an AlpacaTree
     ... (alpaca-dam  alp) ...]   ;; <= same here
    [else
     ...]))

; ============================= step 4 =============================
#;
(define (process-alpaca-tree alp ...)
  (cond
    [(alpaca? alp)
     ... (alpaca-name alp) ...
     ... (alpaca-sex alp) ...
     ... (alpaca-dob alp) ...
     ... (alpaca-color alp) ...
     ... (process-alpaca-tree (alpaca-sire alp) ...) ...
     ... (process-alpaca-tree (alpaca-dam  alp) ...) ...]
    [else
     ...]))




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

; A LoC is one of
; - '()
; - (cons Class LoC)

#;
(define (process-LoC loc ...)
  (cond
    [(empty? loc) ...]
    [(cons? loc)
     ... (first loc) ...
     ... (process-LoC (rest loc)) ...]))




; Exercise 3. Design a function select-name-from-db : LoC -> LoS that takes a
; LoC and returns the name of all courses. For the definition of LoS, see
; course note 14-abstraction.rkt.

; select-name-from-db : LoC -> LoS
; (purpose: from exercise)
; Examples.
(check-expect
 (select-name-from-db '())
 '())
(check-expect
 (select-name-from-db (cons EECS111 (cons EECS211 (cons EECS213 '()))))
 (list
  "Fundamentals of Computer Programming I"
  "Fundamentals of Computer Programming II"
  "Introduction to Computer Systems"))
(define (select-name-from-db loc)
  (cond
    [(empty? loc) '()]
    [(cons? loc) (cons (class-name (first loc))
                       (select-name-from-db (rest loc)))]))




; Exercise 4. Design a function select-from-db-where-year-is : LoC Number -> LoC
; that takes a LoC, a year and returns the classes in LoC with the specified
; year.

; select-from-db-where-year-is : Loc Number -> LoC
; (purpose: from exercise)
; Examples.
(check-expect
 (select-from-db-where-year-is '() 2018)
 '())
(check-expect
 (select-from-db-where-year-is
  (cons EECS111 (cons EECS211 (cons EECS213 '())))
  2018)
 (cons EECS211 (cons EECS213 '())))
(define (select-from-db-where-year-is loc year)
  (cond
    [(empty? loc) '()]
    [(cons? loc)
     (if (equal? (class-year (first loc)) year)
         (cons (first loc)
               (select-from-db-where-year-is (rest loc) year))
         (select-from-db-where-year-is (rest loc) year))]))




; Exercise 5. Design a function select-name-from-db-where-year-is : LoC Number
; -> LoS that returns the name of all courses with the specified year.

; select-name-from-db-where-year-is : LoS Number -> LoS
; (purpose: from exercise)
; Examples.
(check-expect
 (select-name-from-db-where-year-is '() 2018)
 '())
(check-expect
 (select-name-from-db-where-year-is
  (cons EECS111 (cons EECS211 (cons EECS213 '())))
  2018)
 (cons "Fundamentals of Computer Programming II"
       (cons "Introduction to Computer Systems" '())))
(define (select-name-from-db-where-year-is los year)
  (select-name-from-db
   (select-from-db-where-year-is los year)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART II : Advanced ;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise 6. Complete the design of first* and rest* Exercise 176.
; https://bit.ly/2VpNY8P
;
; Hint. What data type does `first*` and `rest*` operate on, in the `else`
; clause of `transpose`? Why isn't it just `Matrix` and `Row`?
;
; After finishing `first*` and `rest*`, `transpose` should work.

; We will operate on a slightly different data type that restricts the rows
; in a matrix to be nonempty. Since the first clause of `transpose` already
; tested whether `(first lln)` is empty, in the `else` clause we will have
; 1Matrix, matrices with non-empty rows.

; A 1Matrix is one of:
;  – (cons 1Row '())
;  – (cons 1Row 1Matrix)
; constraint all rows in matrix are of the same length

; An 1Row is one of:
;  – (cons Number '())
;  – (cons Number 1Row)

; first* : 1Matrix -> Row
; Transpose the first column in 1Matrix in to a Row.
; Examples
(check-expect
 (first* (list
          (list 5 6 7)))
 (list 5))
(check-expect
 (first* (list
          (list 5 6 7)
          (list 3 4 1)
          (list 8 7 2)
          (list 1 3 4)))
 (list 5 3 8 1))
(define (first* lln1)
  (cond
    [(empty? (rest lln1)) (cons (first (first lln1)) '())]
    [else (cons (first (first lln1)) (first* (rest lln1)))]))

; rest* : 1Matrix -> Matrix
; Remove the first column in a 1Matrix, obtaining a Matrix.
(check-expect
 (rest* (list
         (list 1)))
 (list '()))
(check-expect
 (rest* (list
         (list 5 6 7)))
 (list (list 6 7)))
(check-expect
 (rest* (list
         (list 5 6 7)
         (list 3 4 1)
         (list 8 7 2)
         (list 1 3 4)))
 (list
  (list 6 7)
  (list 4 1)
  (list 7 2)
  (list 3 4)))
(define (rest* lln1)
  (cond
    [(empty? (rest lln1))
     (cons (rest (first lln1)) '())]
    [else
     (cons (rest (first lln1))
           (rest* (rest lln1)))]))



; Exercise 7. Design a function that sorts a list of numbers in
; descending order. You can do this following the list template, with a
; helper that also follows the list template in order to insert one
; number in the correct position into a list that's already sorted.
; (This algorithm is called insertion sort.)
;
; Reference solution: https://bit.ly/2PTIBbG
