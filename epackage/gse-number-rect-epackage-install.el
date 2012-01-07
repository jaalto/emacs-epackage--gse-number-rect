(autoload 'gse-number-rectangle                 "gse-number-rect" "" t)

(unless (lookup-key global-map "\C-xrN")
  (global-set-key "\C-xrN" 'gse-number-rectangle))

(provide 'gse-number-rect-epkg-xactivate)
