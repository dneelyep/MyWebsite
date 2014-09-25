;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; site-generation.el                                                      ;;;;;;;;;;;;;;
;;;;;;;;;; This file contains all of the code used to create the site from source. ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;
;;;;; Includes ;;;;;
;;;;;;;;;;;;;;;;;;;;
(require 'cl-lib)
(load-file "constants.el")

;;;;;;;;;;;;;;;;;;;;;
;;;;; Functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;
; TODO Whenever I call make-site, or maybe deploy-site, I should
;      perform a VC commit automatically tagged for the current day.
(defun make-site ()
  "Generates a set of HTML pages, using our current set of input files."
  (interactive)

  ; Process regular pages.
  (setq files-to-process (get-web-site-content-files))
  (generate-html-output files-to-process)

  ; Process blog posts.
  (setq blog-posts (get-web-site-blog-files))
  (generate-html-output blog-posts))

(defun get-web-site-content-files ()
  "Returns a list of all the content files that make up the web site."
  (setq files-without-directory
	(remove "."
		(remove ".."
			(remove "blog"
				(directory-files pages-directory)))))

  (mapcar
   (lambda (file) (concat pages-directory file))
   files-without-directory))

(defun get-web-site-blog-files ()
  "Returns a list of all the files that make up the blog on the web site."
  (setq files-without-directory
	(remove "."
		(remove ".."
			(directory-files blog-directory))))

  (mapcar
   (lambda (file) (concat blog-directory file))
   files-without-directory))

; TODO I need to make and use a utility library. First item to add into it:
;      (defun prepend (text list)
;	"Prepends the provided text to every item in the provided list."
;	(mapcar 
;        (lambda (list-element) (concat text list-element))
;        list))
; TODO Need to make a prefix to use just for this package. Maybe dnsite-*?
(defun generate-html-output (files-to-process)
  "Use the provided list \files-to-process\ to generate HTML pages."
  (mapc 'make-html-file files-to-process))

(defun make-html-file (file)
  "Converts the provided file into an HTML file, and places it in the \html-directory\."
  (setq output-file-path
	(concat html-directory
		(substring (file-name-sans-extension file)
			   (length site-root)) ; Ignore the ../
		html-extension))
  (setq html-output (convert-org-to-html file))

  (with-temp-buffer
    (insert (convert-html-to-string html-output))
    (when (file-writable-p output-file-path)
      (write-region (point-min)
		    (point-max)
		    output-file-path))))

(defun convert-org-to-html (org-mode-file)
  "Uses a set of rules to convert the provided Org mode file into HTML, and returns it."

  (setq file-lines (split-string (org-file-contents org-mode-file) "\n" t))

  (setq html-text "")
  (setq html-text (concat html-text "<html>\n"))
  (setq html-text (concat html-text (get-site-heading)))

  (setq html-text (concat html-text "  <body>\n"))
  (mapcar
   (lambda (line) (setq html-text (concat html-text (convert-line-to-html line) "\n")))
   file-lines)

  (setq html-text (concat html-text "  </body>\n"))

  (setq html-text (concat html-text "</html>"))
  html-text)

(defun get-site-heading ()
  "Returns a string of HTML used to fill each page's <head> tag."
  (concat
   "  <head>\n"
   "    <link rel=\"stylesheet\" type=\"text/css\" href=\"" site-style-sheet "\" media=\"screen\" />\n"
   "  </head>\n"))

(defun convert-html-to-string (html-file)
  "Convert the provided HTML object into literal HTML that can be inserted into a file."
  html-file)

(defun convert-line-to-html (line)
  "Converts the provided line of org-mode text into a line of HTML."
  (cond
   ((string/starts-with line "* ")
    (concat "<h1>" (substring line (length "* ")) "</h1>"))
   ((string/starts-with line "** ")
    (concat "<h2>" (substring line (length "** ")) "</h2>"))
   ((string/starts-with line "*** ")
    (concat "<h3>" (substring line (length "*** ")) "</h3>"))
   ((string/starts-with line "**** ")
    (concat "<h4>" (substring line (length "**** ")) "</h4>"))
   ((string/starts-with line "***** ")
    (concat "<h5>" (substring line (length "***** ")) "</h5>"))
   ((string/starts-with line "****** ")
    (concat "<h6>" (substring line (length "****** ")) "</h6>"))
   (t
    line)))

; TODO These functions were taken from http://www.emacswiki.org/emacs/ElispCookbook#toc1.
;      They should be placed in my utility-library.
(defun string/ends-with (string suffix)
  "Return t if STRING ends with SUFFIX."
  (and (string-match (rx-to-string `(: ,suffix eos) t)
		     string)
       t))

(defun string/starts-with (string prefix)
  "Return t if STRING starts with prefix."
  (and (string-match (rx-to-string `(: bos ,prefix) t)
		     string)
       t))
