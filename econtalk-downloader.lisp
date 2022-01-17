(ql:quickload '("dexador" "cl-ppcre" "trivial-download"))

(defparameter *download-dir* #P"~/econtalk-downloads/")
(defparameter *rss-url* "https://feeds.simplecast.com/wgl4xEgL")
(defparameter *request* (dex:get *rss-url*))

(defparameter *mp3s*
  (cl-ppcre:all-matches-as-strings "https://.*.mp3" *request*))

(defparameter *filenames*
  (cl-ppcre:all-matches-as-strings "<itunes:title>.*</itunes:title>"*request*))

(loop for i from 0 to (- (length *filenames*) 1)
      do (setf (nth i *filenames*)
               (cl-ppcre:regex-replace "<itunes:title>" (nth i *filenames*) ""))
         (setf (nth i *filenames*)
               (cl-ppcre:regex-replace "</itunes:title>" (nth i *filenames*) ""))
         (setf (nth i *filenames*)
               (concatenate 'string (nth i *filenames*) ".mp3")))

(loop for i from 0 to (- (length *filenames*) 1)
      do (unless
             (probe-file (merge-pathnames *download-dir* (nth i *filenames*)))
           (format t "downloading ~d of ~d ~%" (1+ i) (length *filenames*))
           (trivial-download:download (nth i *mp3s*)
                                      (merge-pathnames *download-dir* (nth i *filenames*)))))
