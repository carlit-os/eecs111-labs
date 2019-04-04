;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 05-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART I : Basics ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;z

; Exercise 0. What is the syntax of a function signature?
; Which step in the design recipe does the signature follow from?
; What does the signature of functions tell you?

#|
Syntax:

    <function-name> : <Data_1> <Data_2> ... <Data_n> -> <Data_result>

The signatures, which is the second step, follows from the first step
in design recipe. After analyzing that data we need and what data the
function will be working on, we will know what <Data_i>s should be.

The signature serves as a contract between the user and the provider
of <function-name>.

To the user, this signature _requires_ that the arguments used to call
<function-name> must be the values in <Data_1> ... <Data_n> and
_ensures_ that the call will results in a value in <Data_result>

To the provider, this signature _ensures_ that all arguments that the
function receives will be values in <Data_1> ... <Data_n> and therefore
the function do not to check for values outside this range. This
signature also _requires_ that the function return a value that is
a <Data_reuslt>.
|#




; Exercise 1a. What is a synonym data definition? How do you define a synonym
; data definition?

#|
The ``syntax'' of a synonym data definition is:

    ; A <New-name> is a <Existing-data-definition-name>.

<New-name> is just an alias of <Existing-data-definition-name>.
They will be the same, including their values, their template (if it has one)
and arithmetic operations.
|#




; Exercise 1b. What is an enumeration data definition?
; What is the syntax of an enumeration data definition and
; how to write a template?

#|
Syntax:

    ; A <New-name> is one of
    ; - <value_1>
    ; - <value_2>
    ; ...
    ; - <value_n>

    All <value_i>s must be from the same data type,
    say the name is <Existing-data-definition>.

    Let the equality function of <Existing-data-definition>
    be <existing-data>=?, then

Template:

    #;
    (defiine (process-<new-name> enum-value ...)
      (cond
        [(<existing-data>=? enum-value <value_1>) ...]
        [(<existing-data>=? enum-value <value_2>) ...]
                    ...
        [(<existing-data>=? enum-value <value_n>) ...]))
|#




; Exercise 1c. What is a structure data definition?
; What is the syntax of an structure data definition and
; how to write a template?
;
; What is the name of the constructor, predicate and
; selectors of a struct?

#|
Syntax:

    ; A <New-name> is a (make-<name> Data_1 Data_2 ... Data_n)
    (define-struct <name> (field_1 field_2 ... field_n))
    ; interp. <interpretation of the fields and the entire struct>

Template:

    #;
    (define (process-<new-name> a-struct ...)
      ... (<name>-field_1 a-struct) ...
      ... (<name>-field_2 a-struct) ...
                      ...
      ... (<name>-field_n a-struct) ...)

Constructor      make-<name>
Predicate        <name>?
Selectors        <name>-field_1
                 <name>-field_2
                 ...
                 <name>-field_n
|#




; Exercise 1d. What is an itemization data definition?
; What is the syntax of an itemization data definition and
; how to write a template?

#|
This is _NOT_ the full definition of an itemization data definition.
The itemization data definition introduced in the textbook is
a little more general, but the following definition suffices for now.

Syntax:
    ; A <New-name> is one of
    ; - <Data-type_1>
    ; - <Data-type_2>
    ; ...
    ; - <Data-type_n>

where <Data-type_i> are _DISJOINT_. For example, <Data-type_i>
can be instantiated by (make-<name_i> Data_i_1 Data_i_2 ... Data_i_mi)
so we would obtain

    ; A <New-name> is one of
    ; - (make-<name_1> Data_1_1 Data_1_2 ... Data_1_m1)
    ; - (make-<name_2> Data_2_1 Data_2_2 ... Data_2_m2)
    ...
    ; - (make-<name_n> Data_n_1 Data_n_2 ... Data_n_mn)

Template:

    #;
    (define (process-<name> an-item ...)
      (cond
        [(<data-type_1>? an-item)
         ... structural decomposition of <Data-type_1>]
        [(<data-type_1>? an-item)
         ... structural decomposition of <Data-type_2>]
                             ...
        [(<data-type_1>? an-item)
         ... structural decomposition of <Data-type_n>]))

For example:

    #;
    (define (process-<name> an-item ...)
      (cond
        [(<name_1>? an-item)
         ... (<name_1>-field_1 an-item) ...
                        ...
         ... (<name_1>-field_m1 an-item) ...]
        [(<name_2>? an-item)
         ... (<name_2>-field_1 an-item) ...
                        ...
         ... (<name_2>-field_m2 an-item) ...]
                             ...
        [(<name_n>? an-item)
         ... (<name_n>-field_1 an-item) ...
                        ...
         ... (<name_n>-field_mn an-item) ...]))
|#



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


; For the description of all steps, see 10-recursion.rkt.
; ============================= step 1 =============================
#;
(define (process-alpaca an-alpaca ...)
  (cond
    [...
     ...]
    [...
     ...]))

; ============================= step 2 =============================
#;
(define (process-alpaca an-alpaca ...)
  (cond
    [(alpaca? an-alpaca)
     ...]
    [(string? an-alpaca)
     ...]))

; ============================= step 3 =============================
#;
(define (process-alpaca an-alpaca ...)
  (cond
    [(alpaca? an-alpaca)
     ... (alpaca-name an-alpaca) ...
     ... (alpaca-sex an-alpaca) ...
     ... (alpaca-dob an-alpaca) ...
     ... (alpaca-color an-alpaca) ...
     ... (alpaca-sire an-alpaca) ...    ;; <= note: this is an Alpaca
     ... (alpaca-dam  an-alpaca) ...]    ;; <= same here
    [(string? an-alpaca)
     ...]))

; ============================= step 4 =============================
#;
(define (process-alpaca an-alpaca ...)
  (cond
    [(alpaca? an-alpaca)
     ... (alpaca-name an-alpaca) ...
     ... (alpaca-sex an-alpaca) ...
     ... (alpaca-dob an-alpaca) ...
     ... (alpaca-color an-alpaca) ...
     ... (process-alpaca (alpaca-sire an-alpaca) ...) ...
     ... (process-alpaca (alpaca-dam  an-alpaca) ...) ...]
    [(string? an-alpaca)
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
; http://www.htdp.org/2018-01-06/Book/part_two.html#(counter._(exercise._ex~3atranspose))
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



; Exercise 7. Design a function that sorts a list of numbers in descending
; order (This algorithm is called insertion sort.)
;
; Ref sol:
; http://www.htdp.org/2018-01-06/Book/part_two.html#(part._sec~3asort.I)
