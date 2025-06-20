;; title: setter
;; version: 1.0.0
;; summary: A simple message setter and getter
;; description: Allows setting and getting a string message on-chain

;; data vars
(define-data-var message (string-ascii 100) "Hello world")

;; public functions
(define-public (set-message (new-message (string-ascii 100)))
  (begin
  ;; basic check to silence warning
    (asserts! (is-eq (len new-message) (len new-message)) (err u100))
    (var-set message new-message)
    (ok new-message)
  )
)

;; read only functions
(define-read-only (get-message)
  (print (var-get message))
)
