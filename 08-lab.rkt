;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 07-lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART X : Recursion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; A Key-value-pair is a structure (make-entry String JSON)
(define-struct entry [key val])
; interp. a (make-entry k v) is a association pair mapping
; the value of the key `k` to `v`.

; A JSON is one of
; - String
; - Number
; - Array
; - Object

; An Array is a [List-of JSON]

; An Object is a (make-object [List-of Key-value-pair])
(define-struct object [table])
; constraint. A key can appear at most once in an object.

; Example. The following Object value represents the JSON object
; `{ "score" : 5,
;    "name": "Jacob",
;    "skills": ["attack", "defense", "heal"] }`
(define OBJECT-EX0
  (make-object
      (list (make-entry "score" 5)
            (make-entry "name" "Jacob")
            (make-entry "skills" (list "attack" "defense" "heal")))))

; Example. The following JSON value represents the JSON value
; `[ 7,
;    "first string",
;    { "score": 5,
;      "name": "Jacob",
;      "skills": ["attack", "defense", "heal"]},
;    [3, 4] ]`
(define JSON-EX0
  (list
   7
   "first string"
   OBJECT-EX0
   (list 3 4)))

; Exercise. Can you give some JSON example?

; Exercise. Please write a template for the JSON data type. (This is a
; mutually recursive data type - there should be a few functions calling
; each other.)

; Exercise. Please implement a function `lookup` that, given a key : String
; and an Object, returns the JSON value associated with the key and #false
; if the key does not exists.
;
; (Note that you need to define a new data type for return values. What
;  is the template for that data type?)

; A JSON-option is one of
; - JSON
; - #false





; Exercise. Please implement a function `insert` that, given key : String,
; a value : JSON and an Object, inserts the key-value association pair
; into the Object if key does not exist in that object, or override the
; old value associated with the key by the new value.
;
; In this function, the actual order of the key-value pairs does not matter.
; We only demand that the lookup result be correct.






; An Editor is a structure (make-edit JSON [List-of JSON-focus])
(define-struct edit [cursor path])
; interp. A (make-edit `val` `path`) represents an editor state where
; the current focus of edit (cursor) is the value `val`. In order to go
; from the original JSON value to the inner `val`, we go through a list
; of focus points `path`, in reverse order (i.e. the focuses in the front
; are the innermost focuses).

#|
See "A Graphical Editor, Revisited" for the idea of a zipper.
http://www.htdp.org/2018-01-06/Book/part_two.html#%28part._list-edit2._sec~3aedit2%29
|#

; A JSON-focus is one of
; - Array-focus
; - Object-focus

; An Array-focus is a structure (make-zipper/array [List-of JSON] [List-of JSON])
(define-struct zipper/array [before after])
; interp. We can view the Array-focus as a representation of a "cursor" in
; an Array (list of JSON values). A (make-zipper/array xs ys) represents
; an array `(append (reverse xs) ?? ys)` where the cursor is currently between
; `(reverse xs)` and `ys`.
;
; Again, please refer to "A Graphical Editor, Revisited" for why `xs`
; is reversed.


; An Object-focus is a structure (make-zipper/object String Object)
(define-struct zipper/object [key object])
; interp. The Object-focus data type represents the "cursor" pointing at
; a key in some object. A (make-zipper/object k obj) represents a editing
; state where the cursor is currently pointing at the key `k` in `obj`.

; Examples of Editor.
; In JSON-EX0, suppose we want to edit the entire JSON value, the editor is
(define EDIT-EX0
  (make-edit JSON-EX0 '()))

; In JSON-EX0, suppose we want to focus on the second element, "first string"
; instead:
(define EDIT-EX1
  (make-edit
   "first string"
   (list
    (make-zipper/array (list 7) (list OBJECT-EX0 (list 3 4))))))

; We can also focus on the third element, the JSON object OBJECT-EX0.
; Note the reversed order in zipper/array-before.
(define EDIT-EX2
  (make-edit
   OBJECT-EX0
   (list
    (make-zipper/array (list "first string" 7) (list (list 3 4))))))

; Now, let's go one layer deeper, focusing on the "skills" value in OBJECT-EX0.
(define EDIT-EX3
  (make-edit
   (list "attack" "defense" "heal")
   (list
    (make-zipper/object "skills" OBJECT-EX0)
    (make-zipper/array (list "first string" 7) (list (list 3 4))))))

#|
Pictorally, in the JSON value JSON-EX3, we are currently focusing at
the value pointed by >>>>> _ <<<<<

[ 7,
  "first string",
  { "score": 5, "name": "Jacob",
    "skills": >>>>> ["attack", "defense", "heal"] <<<<< },
  [3, 4] ]

The bottom-most Array-focus, (make-zipper/array (list "first string" 7)
                                                (list (list 3 4))),
indicates that we are focusing on the third element of an array where
the first two elements are 7, "first string" and the last element is (list 3 4)

[ 7,
  "first string",
  >>>>> _ <<<<<,
  [3, 4] ]

Going inside _, the next focus point is (make-zipper/object "skills" OBJECT-EX0)
indicating that we are focusing on the values associated with "skills" in
OBJECT-EX0:

[ 7,
  "first string",

  { "score": 5,
    "name": "Jacob",
    "skills": >>>>> _ <<<<< },

  [3, 4] ]

And finally, the current existing value under the cursor is ["attack",
"defense", "heal"] as recorded in (edit-cursor EDIT-EX3).
At this point, we can modify the list of skills in the hole to be, say,
[ "SUP" ]
|#
(define EDIT-EX4
  (make-edit
   (list "SUP")
   (list
    (make-zipper/object "skills" OBJECT-EX0)
    (make-zipper/array (list "first string" 7) (list (list 3 4))))))
#|
representing the editor state

[ 7,
  "first string",
  { "score": 5, "name": "Jacob",
    "skills": >>>>> ["SUP"] <<<<< },
  [3, 4] ]
|#

; Here's a function that edits the current value under the cursor.
;
; set-value : JSON -> [Editor -> Editor]
; Set the value under the cursor to the new value.
;
; Examples.
(check-expect ((set-value "hi") EDIT-EX0) (make-edit "hi" '()))
(check-expect ((set-value (list "SUP")) EDIT-EX3) EDIT-EX4)
(define (set-value json)
  (local [(define (override-value-under-cursor editor)
            (make-edit json (edit-path editor)))]
    override-value-under-cursor))

; Exercise. Please define a function assemble that calculate the new JSON
; value after moving the cursor out by one layer. To be specific,
; the assemble function takes a JSON-focus, a JSON and assembles them
; together to form a complete JSON value.
;
; As an example, assembling the first focus with the object under
; the cursor in EDIT-EX1 should give JSON-EX0.
; As another example, assembling up (make-zipper/object "skills" OBJECT-EX0)
; with (list "SUP") should give
;   (make-object (list (make-entry "skills" (list "SUP"))
;                      (make-entry "score" 5)
;                      (make-entry "name" "Jacob")))





(define JSON-EX3
  (list
   7
   "first string"
   (make-object
      (list (make-entry "skills" (list "attack" "defense" "heal"))
            (make-entry "score" 5)
            (make-entry "name" "Jacob")))
   (list 3 4)))

(define JSON-EX4
  (list
   7
   "first string"
   (make-object
      (list (make-entry "skills" (list "SUP"))
            (make-entry "score" 5)
            (make-entry "name" "Jacob")))
   (list 3 4)))

(define JSON-EX5
  (list
   7
   "last string"
   (make-object
      (list (make-entry "skills" (list "SUP"))
            (make-entry "score" 5)
            (make-entry "name" "Jacob")))
   (list 3 4)))


; Exercise. Please design a function finish-editing that assembles
; a Editor back to a JSON value. (Hint: going from inside-out)

; finish-editing : Editor -> JSON
; Finish editing, plug the value in the cursor back to form a JSON value.
;
; Examples.
(check-expect (finish-editing EDIT-EX0) JSON-EX0)
(check-expect (finish-editing EDIT-EX1) JSON-EX0)
(check-expect (finish-editing EDIT-EX3) JSON-EX3)
(check-expect (finish-editing EDIT-EX4) JSON-EX4)

(define (finish-editing edt)
  "[YOUR CODE HERE]")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PART Y : Fun! ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Exercise. Please design a function zoom-out : Editor -> Editor
; that moves the focus of the cursor out one layer. If the cursor is currently
; at the outer-most layer, do nothing.





; Exercise. Please design a function zoom-in-key : String Editor -> Editor
; that, if the JSON value under the cursor is a JSON object, move the cursor
; into the JSON object and focus at the value associated with key.
;
; If the value under the cursor is not a JSON object or the key does not
; exists, do nothing.





; Exercise. Please design a function zoom-in-array : Editor -> Editor
; that, if the JSON value under the cursor is an Array, move the cursor
; into the Array and focus on the first element.
;
; If the value under the cursor is not an Array or the array is empty,
; do nothing.





; Exercise. Please design a function move-right : Editor -> Editor
; that, if the cursor is currently focusing on some element in an Array,
; move the cursor to the right by one position.
;
; If this is not the case or the cursor is at the right-most position,
; do nothing.





; Exercise. Please design a function move-left : Editor -> Editor
; that, if the cursor is currently focusing on some element in an Array,
; move the cursor to the left by one position.
;
; If this is not the case or the cursor is at the left-most position,
; do nothing.






; After having all these functions, we can apply an edit sequence to a JSON
; object and obtain a final value.
;
; Delete '#;' in this test after you finished the functions
#;
(check-expect
 (finish-editing
  (foldl
   (λ (action json) (action json))
   EDIT-EX0
   (list
    zoom-in-array
    move-right
    move-right
    (λ (j) (zoom-in-key "skills" j)) ; If you like, zoom-* functions can also
    (set-value (list "SUP"))         ; be modified to have the same style as
    zoom-out                         ; set-value, allowing one to omit the
    move-left                        ; (λ (j) (... j)) part.
    (set-value "last string"))))     ; This is called currying.
 JSON-EX5)
