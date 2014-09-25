;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; site-scripts.el                                                          ;;;;;;;;;;;;;;
;;;;;;;;;; This file contains various utility scripts to ease maintaining the site. ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;;;;; Includes ;;;;;
;;;;;;;;;;;;;;;;;;;;
(load-file "constants.el")

;;;;;;;;;;;;;;;;;;;;;
;;;;; Functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;
(defun new-site-page (page-to-create)
  "Create a new page on the website."
  (interactive "sEnter the page name: ")

  (setq page-path (concat pages-directory page-to-create org-extension))
  (find-file page-path)
  (insert page-default-text))

; TODO Need to add a tags file to ease program navigation.
(defun make-new-page (page-to-create)
  "Alias for new-site-page"
  (interactive "sEnter the page name: ")
  (new-site-page page-to-create))

(defun new-site-blog-post (blog-post-to-create)
  "Adds a new blog post to the website."
  (interactive "sEnter the blog post name: ")

  (setq blog-page-path (concat blog-directory blog-post-to-create org-extension))
  (find-file blog-page-path)
  (insert blog-post-default-text))

(defun make-new-blog-post (blog-post-to-create)
  "Alias for new-site-blog-post"
  (interactive "sEnter the blog-post name: ")
  (new-site-blog-post blog-post-to-create))
