;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; When doing exercises, you can use Ctl/Cmd-I or the Tab key to reindent your
;; code. You can also hit "Check Syntax ✔" to check for any syntax errors and
;; inspect how variables are used in the code.

;; Exercise 0. Compute the following expressions using BSL. Specifically:
;;
;; 1. Open a new tab in DrRacket.
;;
;; 2. Make sure the language in the bottom-left corner is "Beginning Student".
;;
;; 3. Convert the following expression into BSL syntax and put the result
;;    in the definitions window.
;;
;; 4. Hit "Run▹".
;;
;; Expression 1: (4 + 2 × 3) ÷ 10
;;                ________
;; Expression 2: √5² + 12²

;; [YOUR CODE HERE]


;; Exercise 1. Give an example of a String value, an example of a Boolean
;; value, and an example of an Image value.

;; [YOUR CODE HERE]


;; Exercise 2. Arithmetics
;; What do these functions do? Look them up in the documentation and write
;; one test for each of these functions (`check-expect`).
;;
;; These functions are different kinds of arithmetic operations you can perform
;; on different kinds of data, just like the arithmetic of numbers.
;;
;; One way to lookup a function in the documentation:
;;
;; 1. Type the function name in the definition window, like this (but
;;    not in a comment):
;;        sqrt
;;
;; 2. Right-click on the function name and select "Search in Help Desk".
;;
;; 3. To get access to the last three functions in the list below, you need
;;    to add this line of code at the beginning of your file (uncommented):
;;        (require 2htdp/image)
;;
;; Functions to lookup:
;;  - string?
;;  - string-append
;;  - string-length
;;  - number->string
;;  - number?
;;  - =
;;  - >=
;;  - and
;;  - or
;;  - not
;;  - rectangle
;;  - image-width
;;  - overlay/xy



;; Exercise 3. Given the definition of `x-pos`, fill in an expression in place
;; of `...` below to check whether x-pos is in the closed-open interval
;; [3, 6). (Use `and`.)

(define x-pos 5)

; (check-expect ... #true)

;; Exercise 4. Given the definition of `message`, `x`, and `y`, fill in an
;; expression in place of `...` below to make the test pass.

(define x 3)
(define y 8)
(define message "The object is at ")

;(check-expect ... 
;              "The object is at (3, 8).")


;; Exercise 5. Define a function `compute-area` that computes area of an
;; image's *bounding box*. (The bounding box is the smallest rectangle
;; that encloses an image.)
;;
;; Be sure to follow the Design Recipe.

;; compute-area : Image -> Number
;; [YOUR CODE HERE]


;; Exercise 14 from HtDP/2e.
;; http://www.htdp.org/2019-02-24/part_one.html#(counter._(exercise._fun3))
;; Hint: Lookup `string-ith` in the documentation.


;; Exercise 15 from HtDP/2e.
;; http://www.htdp.org/2019-02-24/part_one.html#(counter._(exercise._fun4))
;; Can you implement this function without using a `cond` expression?


;; Exercise 20 from the textbook
;; http://www.htdp.org/2019-02-24/part_one.html#(counter._(exercise._fun10c))
;; Hint: Lookup `substring` in the documentation.


;; Exercise 6. Complete the function `my-overlay`.
;;
;; Question to consider: Should you define the size of the square as a
;; constant?
;;
;; Two examples of input-output pairs may be found here:
;;     https://bit.ly/2IaLQuG

; my-overlay : Image -> Image
; Places a square of size 40 either overlayed atop of the given image if the
; image is wider than the square, or underlayed below the given image if the
; image is not wider than the square.

;; [YOUR CODE HERE]

;(check-expect
; (my-overlay (circle 50 "solid" "blue"))
; (overlay (square 40 "solid" "red") (circle 50 "solid" "blue")))

;; [MORE TESTS HERE]
