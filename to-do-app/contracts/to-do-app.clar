;; title: to-do-app
;; version: v1
;; summary:
;; description:

;; data maps
;; Define the map to store task lists

(define-map lists
  uint
  {
    id: uint,
    title: (string-utf8 100),
    description: (string-utf8 200),
    completed: bool
  }
)

;; Auto-incrementing ID tracker
(define-data-var next-id uint u0)

;; Public function to add a new task
(define-public (add-list (title (string-utf8 100)) (description (string-utf8 200)))
  (let ((id (var-get next-id)))
    (begin
      (map-set lists id {
        id: id,
        title: title,
        description: description,
        completed: false
      })
      (var-set next-id (+ id u1))
      (ok id)
    )
  )
)

;; Update title and description

(define-public (update-list 
  (id uint)
  (title (string-utf8 100))
  (description (string-utf8 200))
  (completed bool)
)
  (match (map-get lists id)
    task
      (begin
        (map-set lists id {
          id: id,
          title: title,
          description: description,
          completed: flase
        })
        (ok true)
      )
  )
)

;; Toggle is-done status



;; read only functions
;; Get a task by id

(define-public (get-by-id (id uint)))
(map-get? )
