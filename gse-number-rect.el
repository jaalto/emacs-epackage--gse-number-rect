;; gse-number-rect.el
;;   Summary:     Inserts incremental numbers in a rectangle.  I love this.
;;   Author:      Scott Evans <gse@antisleep.com>
;;   Home:        http://www.antisleep.com/elisp
;;   Time-stamp:  <2009-03-21 20:19:53 Jari Aalto (jaalto)>
;;
;; Commentary:
;;   Pretty self-expanatory.  If you have text like:
;;     --------------------
;;     Some text here
;;     Another line here
;;     And a final line
;;     --------------------
;;  After selecting a rectangle at the beginning of the lines,
;;  gse-number-rectangle could end you up with
;;     --------------------
;;     1 - Some text here
;;     2 - Another line here
;;     3 - And a final line
;;     --------------------
;; ...assuming you specified a suffix of " - ".
;;
;; I wanted this functionality for soooooo long.  I find it especially
;; useful to rename files, like mp3 files (in conjunction with wdired
;; or gse-rename).
;;
;; Thanks to Juan Leon Lahoz Garcia <juan-leon.lahoz@tecsidel.es>
;; for testing and suggestions.
;;
;; Latest version:
;;   Should be at http://www.antisleep.com/elisp.
;;
;; Installation:
;;   (require 'gse-number-rect)
;;   (global-set-key "\C-xru" 'gse-number-rectangle)
;;
;;---------------------------------------------------------------------------
;; Change Log
;; ----------
;; 2002.04.08 gse Fix off-by-one error in longest computation.
;;                Use 'force' parameter for move-to-column.
;; 2002.04.08 gse Use read-string if read-number not bound (FSF).
;; 2002.04.05 gse Add documentation.
;;---------------------------------------------------------------------------

(autoload 'apply-on-rectangle "rect")

(defvar gse-number-rectangle-count nil)
(defvar gse-number-rectangle-history nil)

(defun gse-number-rectangle-callback (start end format-string)
  (move-to-column start t)
  (setq gse-number-rectangle-count (+ gse-number-rectangle-count 1))
  (insert (format format-string gse-number-rectangle-count)))

(defun gse-number-rectangle (beg end start-at format &optional no-zero-padding)
  "Insert numbers in front of lines in rectangle BEG END.

START-AT specifices the first number to start at.
FORMAT is format string where %i denotes number.
If NO-ZERO-PADDING is non-nil, do not padd numbers with leading zeroes."
  (interactive
   (list
    (region-beginning)
    (region-end)
    (if (functionp 'read-number)
        (read-number "First number [1]: " 1)
      (string-to-int (read-string "First number [1]: " nil nil "1")))
    (read-string "Format: " "%i " 'gse-number-rectangle-history)
    current-prefix-arg))
  (setq start-at (- start-at 1))
  (unless no-zero-padding
    (let* ((max     (+ (count-lines beg end) start-at))
	   (longest (length (int-to-string (+ 1 max))))
	   (fmt     (concat "%0" (int-to-string longest) "i")))
      (setq format (replace-regexp-in-string "%i" fmt format))))
  (setq gse-number-rectangle-count start-at)
  (apply-on-rectangle 'gse-number-rectangle-callback beg end format))

;;---------------------------------------------------------------------------

(provide 'gse-number-rect)


