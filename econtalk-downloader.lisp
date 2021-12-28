(ql:quickload '("dexador" "lquery" "lparallel" "cxml" "cl-ppcre" "trivial-download"))

(defparameter download-dir "/home/john/Downloads/")

(defparameter *rss-url* "https://feeds.simplecast.com/wgl4xEgL")
(defparameter *request* (dex:get *rss-url*))

;; Write the downloaded xml feed to a file.
;; (with-open-file (s "feed.xml" :direction :output)
;;   (write-string *request* s))

;; (defparameter *parsed-content*
;;   (cxml:parse-file "feed.xml" (cxml-dom:make-dom-builder)))

(defparameter *mp3s*
  (cl-ppcre:all-matches-as-strings "https://.*.mp3" *request*))

(defparameter *filenames*
  (cl-ppcre:all-matches-as-strings "<itunes:title>.*</itunes:title>"*request*))

(loop for i from 0 to (- (length *filenames*) 1)
      do
         (setf (nth i *filenames*)
               (cl-ppcre:regex-replace "<itunes:title>" (nth i *filenames*) ""))
         (setf (nth i *filenames*)
               (cl-ppcre:regex-replace "</itunes:title>" (nth i *filenames*) ""))
         (setf (nth i *filenames*)
               (concatenate 'string (nth i *filenames*) ".mp3")))

(defparameter *dat* (pairlis *filenames* *mp3s*))

((trivial-download:download (nth 0 *mp3s*) "/home/john/Downloads/ep1.mp3")
