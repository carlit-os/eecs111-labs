;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 04-lab-done) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
The ''syntax'' of a synonym data definition is:

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
    (define (process-<new-name> enum-value ...)
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
; Please provide the constructor, predicate, and selectors for the Alpaca struct
; then give the template for processing the Alpaca struct, defined below.

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
