;; title: to-do-app
;; version: v1
;; summary:
;; description:

;; data maps

(define-map lists-by-id
  ((id uint)) 
  ((id uint) (title (string-utf8 100)) (description (string-utf8 200)) (is-done bool))
)

;; -- Constants --

(define-constant ERR-NOT-FOUND (err u404))

;; public functions
;; Add a new task


(define-public (add-list (id uint) (title (string-utf8 100)) (description (string-utf8 200)))
  (match (map-get? lists-by-id ((id id)))
    some-task (err u409) ;; Conflict: task already exists
    none
    (begin
      (map-insert lists-by-id
        ((id id))
        ((id id)
         (title title)
         (description description)
         (is-done false))
      )
      (ok id)
    )
  )
)


;; Update title and description

(define-public (update-list (id uint) (new-title (string-utf8 100)) (new-description (string-utf8 200)))
  (match (map-get lists-by-id ((id id)))
    some-task
    (let
      (
        (updated-task (tuple
          (id id)
          (title new-title)
          (description new-description)
          (is-done (get is-done some-task))
        ))
      )
      (begin
        (map-set lists-by-id ((id id)) updated-task)
        (ok true)
      )
    )
    (err u404)
  )
)

;; Toggle is-done status

(define-public (toggle-done (id uint))
  (match (map-get lists-by-id ((id id)))
    some-task
    (let
      (
        (updated-task (tuple
          (id id)
          (title (get title some-task))
          (description (get description some-task))
          (is-done (not (get is-done some-task)))
        ))
      )
      (begin
        (map-set lists-by-id ((id id)) updated-task)
        (ok true)
      )
    )
    (err u404)
  )
)

;; read only functions
;; Get a task by id

(define-read-only (get-list (id uint))
  (match (map-get lists-by-id ((id id)))
    some-task (ok some-task)
    (err u404)
  )
)