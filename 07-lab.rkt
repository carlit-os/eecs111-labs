;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 08-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;; PART X : Map, Filter, Foldr Again ;;;;;;;;;;;;;;;;;;;;;

#|
Please review Part II, 16 for the existing abstractions map, filter, foldr,
andmap and ormap, then finish the following exercises using these functions
without any recursion.

http://www.htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3a3use%29
|#

; A Dec-digit is one of
; - "0"
; - "1"
; - "2"
; - "3"
; - "4"
; - "5"
; - "6"
; - "7"
; - "8"
; - "9"

; Exercise. Please design a function Dec-digits->numbers : [List-of Dec-digit] ->
; [List-of Number] that converts a list of Dec-digits to a list of corresponding
; number. For example, (list "1" "2" "7") should become (list 1 2 7).

#| [YOUR CODE HERE] |#




; Exercise. Please design a function non-zero-digits : [List-of Dec-digit] ->
; [List-of Dec-digit] that, when given a list of Dec-digit, removes all "0"s and
; leave only non-zero digits.

#| [YOUR CODE HERE] |#




; Exercise. Please design a function non-zero-digits? : [List-of Dec-digit] ->
; Boolean that, when given a list of Dec-digit, check whether all digits in
; the given list of Dec-digit are not "0".
;
; (Don't use non-zero-digits previously implemented.)

#| [YOUR CODE HERE] |#




; Exercise. Please design a function dec->number : [List-of Dec-digit] -> Number
; that, given a list of Dec-digit, convert the entire list to a number using
; foldr or foldl. For example, (list "5" "3" "2") converts to 532.


#| [YOUR CODE HERE] |#




#|
Please review Part III, 16.4 for the usage of local.
http://www.htdp.org/2018-01-06/Book/part_three.html#%28part._sec~3aeval-local%29
|#

; Exercise. Instead of implementing the above functions using top-level
; helper functions or lambda functions, please rewrite these functions using
; the local expression.

; Extra Exercise*. Please implement the following functions without using any
; explicit recursion. Don't use sort.
;
; * This exercise is a little little difficult. (> final exam)

; concat : [List-of [List-of Dec-digit]] -> [List-of Dec-digit]
; Concatenate the lists of Dec-digits together.
;
; (concat (list (list d1 d2 ...) (list d3 d4 ...) (list d5 d6 ...) ...))
; = (list d1 d2 ... d3 d4 ... d5 d6 ...)
(define (concat xss)
  ...)

(check-expect (concat (list '("3") '("1" "4") '("1" "5" "9" "2" "6")))
              (list "3" "1" "4" "1" "5" "9" "2" "6"))

; filter-digit : Dec-digit -> [[List-of Dec-digit] -> [List-of Dec-digit]]
; Given a digit `d`, produce a function that, when given a list of Dec-digits,
; will filter out all digits that are not equal to `d`.
;
; (Use the do-filter function and implement digit-equals-d?)
(define (filter-digit d)
  (local
    [#| [YOUR CODE HERE] |#

     (define (do-filter xs)
       (filter #|digit-equals-d?|# xs))]
    ...))

(check-expect
 (local [(define filter-5 (filter-digit "5"))]
   (filter-5 (list "3" "2" "5" "6" "7" "5")))
 (list "5" "5"))

; sort-dec-digits : [List-of Dec-digits] -> [List-of Dec-digits]
; Sort the given list of Dec-digits using neither recursion nor the built-in sort
;
; Hint: use filter-digit on each of "0", "1", ..., "9" and use concat.
(define (sort-dec-digits xs)
  (local
    [(define (call-xs f)
       (f xs))]
    ...))

(define DIGITS-EX
  (list "3" "1" "4" "1" "5" "9" "2" "6" "2" "0" "1" "7" "0" "5" "2" "4"))

(check-expect
 (sort-dec-digits DIGITS-EX)
 (sort DIGITS-EX string<?))

;;;;;;;;;;;;;;;;;;;;;;;; PART Y : Mutual Recursion Again ;;;;;;;;;;;;;;;;;;;;;;;

; Exercise. What are the steps to write a template for a struct whose fields do
; not reference the struct itself? Which step will be changed if some fields
; refer to the same data type again? How does this step change in order to
; process mutual recursive data types?
;
; (Strictly speaking, it's not a struct but rather an itemization.)



; Example structure definitions. Can you write templates for all of them?

; A Short-tree is one of
; - #false
; - A structure (make-stree Number #false #false)
(define-struct stree [data child1 child2])
; interp. child1 and child2 will always be
; the empty value since a short tree has no children.

; A Tall-tree is one of
; - #false
; - A structure (make-ttree Number Tall-tree Tall-tree)
(define-struct ttree [data child1 child2])
; interp. As the definition of Short-tree. However, a Tall-tree can
; has children, so child1 and child2 don't need to be #false
; anymore. They can be arbitrary Tall-tree values.

; A Tall-family is one of
; - #false
; - A structure (make-tfamily Number Tall-family [List-of Tall-family])
(define-struct tfamily [data child1 children])
; interp. In addition to having at most 2 children, a Tall-family node now has
; a list of children. This is a mutually recursive data type since
; [List-of Tall-family] is a separate data type that refers back to the Tall-family
; again. Moreover, we restrict a tfamily node to has at least 1 child. The
; tallest field should store the tallest Tall-family.

#| [YOUR CODE HERE] |#



; Exercise. Please design a function total-data : Tall-family -> Number
; that compute the sum of all data in the given Tall-family (or 0 for
; #false).

#| [YOUR CODE HERE] |#




; Extra Exercise. Can you write maptf for Tall-family that maps over the
; data field in Tall-family?

#| [YOUR CODE HERE] |#





;;;;;;;;;;;;;;;;;;;;;; PART Z : Generative Recursion Basics ;;;;;;;;;;;;;;;;;;;;

; Please write down the general template for generative recursion.

#| [YOUR CODE HERE] |#




; Exercise. Given two numbers start and end, please generate all even numbers
; that are between start and end.
; start and end might or might not be even numbers.
;
; What is trivial-problem? for this function?
; What are sub-problems for this function?
; What is the combine function for this?
; What can be a *measure* for this function?

#| [YOUR CODE HERE] |#




; Exercise. Given two numbers left and right, please generate all pairs
; (list i j) such that left ≤ i, i ≤ j and j < right.
;
; What is trivial-problem? for this function?
; What are sub-problems for this function?
; What is the combine function for this?
; What can be a *measure* for this function?

#| [YOUR CODE HERE] |#
