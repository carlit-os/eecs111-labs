;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01-lab-revised) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; When doing exercises, you can use <Ctrl>-I or command-I or the Tab key to indent your code.
;; You can also hit "Check Syntax ✔" to check for any syntax errors and inspect
;; how variables are used in the code.

;; Exercise 0. Please compute the following expressions using BSL. Specifically,
;; 1. Open a new tab in DrRacket.
;; 2. From the bottom-left corner, choose "Beginning Student".
;; 3. Convert the following expression into BSL syntax and put the result
;;    in the definition window.
;; 4. Hit "Run▹".
;;
;; Expression 1:  (4+2×3)÷10
;;                  ________
;; Expression 2:   √5² + 12²
;;


;; Exercise 1. Please give an example of a String value,
;; an example of a Boolean value and an example of an Image value.

 ; [YOUR CODE HERE]


;; Exercise 2. Arithmetic of Values
;; What do these functions do? Please look them up in the documentation and write
;; one test for each of these functions (check-expect).
;;
;; These functions are different kinds of arithmetic operations you can perform
;; on different kinds of data, just like the arithmetic of numbers.
;;
;; To lookup a function in the documentation,
;; 1. Put the function name in the definition window, like this (without semicolons):
;;        sqrt
;; 2. Right-click on the function name and select "Search in Help Desk".
;; 3. To use the last three function, you need to put this line of code
;;    at the beginning of your file:
;;        (require 2htdp/image)
;;
;; Functions to lookup:
;; - string?
;; - string-append
;; - string-length
;; - number->string
;; - number?
;; - =
;; - >=
;; - and
;; - or
;; - not
;; - rectangle
;; - image-width
;; - overlay/xy

 ; [YOUR CODE HERE]


;; Exercise 3. Given the definition of x-pos, please fill in an expression in '...'
;; to compute whether x-pos is in the range [3,6) using 'and'.

(define x-pos 5)

#|
(check-expect
 ... 
 #true)
|#

;; Exercise 4. Given the definition of message, x and y, please fill in an expression
;; in '...' to produce the same value using message, x and y.

(define x 3)
(define y 8)
(define message "The object is at ")

#|
(check-expect
 ... 
 "The object is at (3, 8).")
|#

;; Exercise 5. Define a function compute-area that computes the area of an image.
;; Please follow the 5-step design recipe.
;; Be sure to require 2htdp/image.

;; compute-area : Image -> Number
 ; [YOUR CODE HERE]


;; Exercise 14 from the textbook
;; http://www.htdp.org/2018-01-06/Book/part_one.html#(counter._(exercise._fun3))
;; Hint: Lookup string-ith in the documentation.


;; Exercise 15 from the textbook
;; http://www.htdp.org/2018-01-06/Book/part_one.html#(counter._(exercise._fun4))
;; Can you implement this function without using the cond expression?


;; Exercise 20 from the textbook
;; http://www.htdp.org/2018-01-06/Book/part_one.html#(counter._(exercise._fun10c))
;; Hint: Lookup substring in the documentation.


;; Exercise 5. Complete the function my-overlay.
;; Question: should you define the size of the square as a constant?
;; Some examples of the input-output pairs are here:
;; https://users.eecs.northwestern.edu/~jesse/course/eecs111/lab/01-lab-my-overlay.png
; my-overlay : Image -> Image
; Places a square of size 40 either on top of the given Image or below the
; given image, depending on whether the given Image is wider than the square or not.
#|
(check-expect
 (my-overlay (circle 50 "solid" "blue"))
 (overlay (square 40 "solid" "red") (circle 50 "solid" "blue")))
(define (my-overlay choose-your-own-argument-name-here)
  ...)
|#
