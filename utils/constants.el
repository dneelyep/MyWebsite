;;;;;;;;;;;;;;;;;;;;;
;;;;; Constants ;;;;;
;;;;;;;;;;;;;;;;;;;;;

;;;;; Directories ;;;;;
(defconst site-root "../" "The root directory of the website")
(defconst blog-directory  (concat pages-directory "blog/") "The path to the website's blog directory")
(defconst html-directory  (concat site-root "html/")  "The path where html output is placed on the website.")
(defconst pages-directory (concat site-root "pages/") "The path to the website's pages directory.")
(defconst resources-directory (concat site-root "../resources/") "The path to resources used by various site pages.")
(defconst utils-directory (concat site-root "utils/") "The path to the website's utils directory.")

;;;;; Special files ;;;;;
(defconst site-style-sheet (concat resources-directory "site-css.css"))

;;;;; File extensions ;;;;;
(defconst file-extension-prefix ".")
(defconst html-extension (concat file-extension-prefix "html"))
(defconst org-extension  (concat file-extension-prefix "org"))

;;;; Text templates ;;;;;
(defconst page-default-text
  (concat "* TODO Page title/heading here.\n"
	  "** TODO First heading here. Probably a quick summary of the page.\n"
	  "TODO Here is a paragraph of plain text that should be replaced with content.\n"
	  "** TODO Here is another heading.\n")
  "The text that is contained by default in a new page when you create one.")

(defconst blog-post-default-text
  (concat "* TODO Blog post titlePage here.\n"
	  "** TODO A heading is here.\n"
	  "TODO Here is a paragraph of plain text that should be replaced with content.\n"
	  "** TODO Here is another heading.\n")
  "The text to be contained by default in a new blog post when you create one.")
