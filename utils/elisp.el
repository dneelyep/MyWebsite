;; This file will contain all of the code used to generate/work with the site.

;;;;;;;;;;;;;;;;;;;;
;;;;; Includes ;;;;;
;;;;;;;;;;;;;;;;;;;;
(require 'cl-lib)

;;;;;;;;;;;;;;;;;;;;;
;;;;; Constants ;;;;;
;;;;;;;;;;;;;;;;;;;;;

;;;;; Directories ;;;;;
(defconst site-root "../" "The root directory of the website")
(defconst utils-directory (concat site-root "utils/") "The path to the website's utils directory.")
(defconst pages-directory (concat site-root "pages/") "The path to the website's pages directory.")
(defconst html-directory  (concat site-root "html/")  "The path where html output is placed on the website.")

;;;;; File extensions ;;;;;
(defconst file-extension-prefix ".")
(defconst html-extension (concat file-extension-prefix "html"))

;;;;;;;;;;;;;;;;;;;;;
;;;;; Functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;
; TODO Whenever I call make-site, or maybe deploy-site, I should
;      perform a VC commit automatically tagged for the current day.
(defun make-site ()
  "Generates a set of HTML pages, using our current set of input files."
  (interactive)
  (setq files-to-process (get-web-site-content-files))
  (generate-html-output files-to-process))

(defun get-web-site-content-files ()
  "Returns a list of all the content files that make up the web site."
  (remove "."
    (remove ".."
      (directory-files pages-directory))))

(defun generate-html-output (files-to-process)
  "Use the provided list \files-to-process\ to generate HTML pages."
  (mapc 'make-html-file files-to-process))

(defun make-html-file (file)
  "Converts the provided file into an HTML file, and places it in the \html-directory\."
  (setq output-file (concat html-directory (file-name-sans-extension file) html-extension))
  (with-temp-buffer
    (insert "Testing")
    (when (file-writable-p output-file)
      (write-region (point-min)
		    (point-max)
		    output-file))))
