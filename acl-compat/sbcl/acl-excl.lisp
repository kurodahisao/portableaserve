;;;;
;;;; ACL-COMPAT - EXCL
;;;;

;;;; Implementation-specific parts of acl-compat.excl (see
;;;; acl-excl-common.lisp)

(in-package :acl-compat.excl)

(defun stream-input-fn (stream)
  stream)

#+ignore
(defun filesys-type (file-or-directory-name)
  (let ((mode (sb-posix:stat-mode (sb-posix:stat file-or-directory-name))))
    (cond
      ((sb-posix:s-isreg mode) :file)
      ((sb-posix:s-isdir mode) :directory)
      (t nil))))

(defun filesys-type (file-or-directory-name)
  (let* ((probe (probe-file file-or-directory-name))
         (namestring (if probe (namestring probe))))
    (if namestring
        (if (char= #\/ (aref namestring (1- (length namestring))))
            :directory
          :file)
      nil)))

(defmacro atomically (&body forms)
  `(acl-mp:without-scheduling ,@forms))

(defun unix-signal (signal pid)
  (declare (ignore signal pid))
  (error "unix-signal not implemented in acl-excl-sbcl.lisp"))

(defun filesys-inode (path)
  (sb-posix:stat-ino (sb-posix:lstat path)))

(defun cl-internal-real-time ()
  (round (/ (get-internal-real-time) internal-time-units-per-second)))

