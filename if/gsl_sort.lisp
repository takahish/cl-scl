;;; cl-gsl/gsl.lisp

(cl:in-package "GSL")

;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 3.0.10
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.


(cffi:defctype size_t :unsigned-int)

(cffi:defctype gsl_comparison_fn_t :pointer)

(cffi:defcfun ("gsl_heapsort" gsl_heapsort) :void
  (array :pointer)
  (count :unsigned-int)
  (size :unsigned-int)
  (compare :pointer))

(cffi:defcfun ("gsl_heapsort_index" gsl_heapsort_index) :int
  (p :pointer)
  (array :pointer)
  (count :unsigned-int)
  (size :unsigned-int)
  (compare :pointer))


