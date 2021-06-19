(require 'package)

;; package-archives
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
	("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(require 'ox-latex)
(require 'ox-bibtex)
(setq pub-dir "./org-mode.tmp")
(setq org-latex-pdf-process
  (list (format "platex -output-directory=%s %%f" pub-dir)
        (format "platex -output-directory=%s %%f" pub-dir)
        (format "pbibtex %s/%%b" pub-dir)
        (format "platex -output-directory=%s %%f" pub-dir)
        (format "platex -output-directory=%s %%f" pub-dir)
        (format "dvipdfmx -o %s/%%b.pdf %s/%%b.dvi" pub-dir pub-dir)))
(setq org-latex-default-packages-alist
                 '(("hidelinks" "hyperref" nil)))
(setq org-src-preserve-indentation t)


(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep)
  (unless (file-directory-p pub-dir)
      (make-directory pub-dir))
  (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)
