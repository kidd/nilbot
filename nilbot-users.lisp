;;                                                               -*- Lisp -*-
;; nilbot-users.lisp --
;;
;; Copyright (C) 2011,2012 David Vazquez
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;

(in-package :nilbot)

(defpclass user ()
  ((nickname
    :initarg :nickname
    :type string
    :initform (required-arg)
    :reader user-nickname
    :index t)
   (permission
    :initarg :permission
    :type string
    :accessor user-permission)))

(defmethod print-object ((x user) stream)
  (print-unreadable-object (x stream :type t)
    (format stream "~a" (user-nickname x))))

(defun find-user (name)
  (get-instance-by-value 'user 'nickname name))

(defmethod user-nickname ((nickname string))
  nickname)

(defmethod user-permission ((nickname string))
  (let ((user (find-user nickname)))
    (if user
        (user-permission user)
        "nobody")))

(defun add-user (name permission)
  (if (find-user name)
      (error "The user ~a exists." name)
      (create-instance 'user :nickname name :permission permission))
  (values))

(defun list-users ()
  (mapcar #'user-nickname (get-instances-by-class 'user)))

;;; nilbot-users.lisp ends here
