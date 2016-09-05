;;;; cl-gsl/matrix.lisp
;;;;
;;;; Matrices are defined by a gsl-matrix structure which describes a
;;;; generalized slice of a block. Like a vector it represents a set of
;;;; elements in an area of memory, but uses two indices instead of one.

;;;; Copyright (C) 2016 Takahiro Ishikawa
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation, either version 3 of the License, or
;;;; (at your option) any later version.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program. If not, see http://www.gnu.org/licenses/.

(cl:in-package "GSL")

(defclass matrix-t ()
  ((entity :accessor entity :initarg :entity)))

(defclass matrix-double (matrix-t) ())

(defclass matrix-float (matrix-t) ())

(defun matrix-alloc (n1 n2 &key (ctype :double))
  "This function create a matrix of size n1 rows by n2 columns, returning a pointer
to a newly initialized matrix struct. A new block is allocated for the elements of
the matrix, and stored in the block component of the matrix struct. The bclok is
owned by the matrix, and will be deallocated when the matrix is deallocated."
  (cond ((eq ctype :double)
         (make-instance 'matrix-double :entity (gsl_matrix_alloc n1 n2)))
        ((eq ctype :float)
         (make-instance 'matrix-float :entity (gsl_matrix_float_alloc n1 n2)))
        (t (error "unknown ctype"))))

(defun matrix-calloc (n1 n2 &key (ctype :double))
  "This function allocates memory for a matrix of size n1 rows by n2 columns and
initializes all the elements of the matrix to zero."
  (cond ((eq ctype :double)
         (make-instance 'matrix-double :entity (gsl_matrix_calloc n1 n2)))
        ((eq ctype :float)
         (make-instance 'matrix-float :entity (gsl_matrix_float_calloc n1 n2)))
        (t (error "unknown ctype"))))

(defgeneric matrix-free (m &optional result)
  (:documentation
   "This function frees a previously allocated matrix m. If the matrix was created using
gsl_matrix_alloc then the block underlying the matrix will also be deallocated."))

(defmethod matrix-free ((m matrix-double) &optional (result nil))
  (gsl_matrix_free (entity m))
  result)

(defmethod matrix-free ((m matrix-float) &optional (result nil))
  (gsl_matrix_float_free (entity m))
  result)

(defgeneric matrix-get (m i j)
  (:documentation
   "This function returns the (i,j)-th element of a matrix m. If i or j lie outside the
allowed range of 0 to n1-1 and 0 to n2-1 then the error handler is invoked and 0
is returned. An inline version of this function is used when HAVE_INLINE is defined."))

(defmethod matrix-get ((m matrix-double) i j)
  (gsl_matrix_get (entity m) i j))

(defmethod matrix-get ((m matrix-float) i j)
  (gsl_matrix_float_get (entity m) i j))

(defgeneric matrix-set (m i j x)
  (:documentation
   "This function sets the value of the (i,j)-th element of a matrix m to x. If i or j lies
outside the allowed range of 0 to n1-1 and 0 to n2-1 then the error handler is
invoked. An inline version of this function is used when HAVE_INLINE is defined."))

(defmethod matrix-set ((m matrix-double) i j x)
  (gsl_matrix_set (entity m) i j x)
  m)

(defmethod matrix-set ((m matrix-float) i j x)
  (gsl_matrix_float_set (entity m) i j x)
  m)

(defgeneric matrix-ptr (m i j)
  (:documentation
   "This function return a pointer to the (i,j)-th element of a matrix m. If i or j lie
outside the allowed range of 0 to n1-1 and 0 to n2-1 then the error handler is
invoked and a null pointer is returned."))

(defmethod matrix-ptr ((m matrix-double) i j)
  (gsl_matrix_ptr (entity m) i j))

(defmethod matrix-ptr ((m matrix-float) i j)
  (gsl_matrix_float_ptr (entity m) i j))

(defgeneric matrix-set-all (m x)
  (:documentation
   "This function sets all the elements of the matrix m to the value x."))

(defmethod matrix-set-all ((m matrix-double) x)
  (gsl_matrix_set_all (entity m) x)
  m)

(defmethod matrix-set-all ((m matrix-float) x)
  (gsl_matrix_float_set_all (entity m) x)
  m)

(defgeneric matrix-set-zero (m)
  (:documentation
   "This function sets all the elements of the matrix m to zero."))

(defmethod matrix-set-zero ((m matrix-double))
  (gsl_matrix_set_zero (entity m))
  m)

(defmethod matrix-set-zero ((m matrix-float))
  
  (gsl_matrix_float_set_zero (entity m))
  m)

(defgeneric matrix-set-identity (m)
  (:documentation
   "This function sets the elements of the matrix m to the corresponding elements of the
identity matrix m(i,j) = delta(i,j), i.e. a unit diagonal with all off-diagonal
elements zero. This applies to both square and rectangular matrices."))

(defmethod matrix-set-identity ((m matrix-double))
  (gsl_matrix_set_identity (entity m))
  m)

(defmethod matrix-set-identity ((m matrix-float))
  (gsl_matrix_float_set_identity (entity m))
  m)

(defgeneric matrix-memcpy (dest src)
  (:documentation
   "This function copies the elements of the matrix src into the matrix dest. The two
matrices must have the same size."))

(defmethod matrix-memcpy ((dest matrix-double) (src matrix-double))
  (gsl_matrix_memcpy (entity dest) (entity src))
  dest)

(defmethod matrix-memcpy ((dest matrix-float) (src matrix-float))
  (gsl_matrix_float_memcpy (entity dest) (entity src))
  dest)

(defgeneric matrix-swap (m1 m2)
  (:documentation
   "This function exchanges the elements of the matrices m1 and m2 by copying. The
two matrices must have the same size."))

(defmethod matrix-swap ((m1 matrix-double) (m2 matrix-double))
  (gsl_matrix_swap (entity m1) (entity m2))
  (values m1 m2))

(defmethod matrix-swap ((m1 matrix-float) (m2 matrix-float))
  (gsl_matrix_float_swap (entity m1) (entity m2))
  (values m1 m2))

(defgeneric matrix-get-row (v m i)
  (:documentation
   "This function copies the elements of the i-th row of the matrix m into the vector v.
The length of the vector must be the same as the length of the column."))

(defmethod matrix-get-row ((v vector-double) (m matrix-double) i)
  (gsl_matrix_get_row (entity v) (entity m) i)
  v)

(defmethod matrix-get-row ((v vector-float) (m matrix-float) i )
  (gsl_matrix_float_get_row (entity v) (entity m) i)
  v)

(defgeneric matrix-get-col (v m j)
  (:documentation
   "This function copies the elements of the j-th column of the matrix m into the vector
v. The length of the vector must be the same as the length of the row."))

(defmethod matrix-get-col ((v vector-double) (m matrix-double) j)
  (gsl_matrix_get_col (entity v) (entity m) j)
  v)

(defmethod matrix-get-col ((v vector-float) (m matrix-float) j)
  (gsl_matrix_float_get_col (entity v) (entity m) j)
  v)

(defgeneric matrix-set-row (m i v)
  (:documentation
   "This function copies the elements of the vector v into the i-th row of the matrix m.
The length of the vector must be the same as the length of the column."))

(defmethod matrix-set-row ((m matrix-double) i (v vector-double))
  (gsl_matrix_set_row (entity m) i (entity v))
  m)

(defmethod matrix-set-row ((m matrix-float) i (v vector-float))
  (gsl_matrix_set_row (entity m) i (entity v))
  m)

(defgeneric matrix-set-col (m j v)
  (:documentation
   "This function copies the elements of the vector v into the j-th column of the matrix
m. The length of the vector must be the same as the length of the row."))

(defmethod matrix-set-col ((m matrix-double) j (v vector-double))
  (gsl_matrix_set_col (entity m) j (entity v))
  m)

(defmethod matrix-set-col ((m matrix-float) j (v vector-float))
  (gsl_matrix_float_set_col (entity m) j (entity v))
  m)

(defgeneric matrix-swap-rows (m i j)
  (:documentation
   "This function exchanges the i-th and j-th rows of the matrix m in-place."))

(defmethod matrix-swap-rows ((m matrix-double) i j)
  (gsl_matrix_swap_rows (entity m) i j)
  m)

(defmethod matrix-swap-rows ((m matrix-float) i j)
  (gsl_matrix_float_swap_rows (entity m) i j)
  m)

(defgeneric matrix-swap-columns (m i j)
  (:documentation
   "This function exchanges the i-th and j-th columns of the matrix m in-place."))

(defmethod matrix-swap-columns ((m matrix-double) i j)
  (gsl_matrix_swap_columns (entity m) i j)
  m)

(defmethod matrix-swap-columns ((m matrix-float) i j)
  (gsl_matrix_float_swap_columns (entity m) i j)
  m)

(defgeneric matrix-swap-rowcol (m i j)
  (:documentation
   "This function exchange the i-th row and j-th column of the matrix m inplace. The
matrix must be square for this operation to be possible."))

(defmethod matrix-swap-rowcol ((m matrix-double) i j)
  (gsl_matrix_swap_rowcol (entity m) i j)
  m)

(defmethod matrix-swap-rowcol ((m matrix-float) i j)
  (gsl_matrix_float_swap_rowcol (entity m) i j)
  m)

(defgeneric matrix-transpose-memcpy (dest src)
  (:documentation
   "This function makes the matrix dest the transpose of the matrix src by copying the
elements of src into dest. This function works for all matrices provided that the
dimensions of the matrix dest match the transposed dimensions of the matrix src."))

(defmethod matrix-transpose-memcpy ((dest matrix-double) (src matrix-double))
  (gsl_matrix_transpose_memcpy (entity dest) (entity src))
  dest)

(defmethod matrix-transpose-memcpy ((dest matrix-float) (src matrix-float))
  (gsl_matrix_float_transpose_memcpy (entity dest) (entity src))
  dest)

(defgeneric matrix-transpose (m)
  (:documentation
   "This function replaces the matrix m by its transpose by copying the elements of the
matrix in-place. The matrix must be square for this operation to be possible."))

(defmethod matrix-transpose ((m matrix-double))
  (gsl_matrix_transpose (entity m))
  m)

(defmethod matrix-transpose ((m matrix-float))
  (gsl_matrix_float_transpose (entity m))
  m)

(defgeneric matrix-add (a b)
  (:documentation
   "This fuction adds the elements of matrix b to the elements of matrix a. The result
a(i,j) <- a(i,j) + b(i,j) is stored in a and b remains unchanged. The two matrices
must have the same dimensions."))

(defmethod matrix-add ((a matrix-double) (b matrix-double))
  (gsl_matrix_add (entity a) (entity b))
  a)

(defmethod matrix-add ((a matrix-float) (b matrix-float))
  (gsl_matrix_float_add (entity a) (entity b))
  a)

(defgeneric matrix-sub (a b)
  (:documentation
   "This function subtracts the elements of matrix b from the elements of matrix a. The
result a(i,j) <- a(i,j) - b(i,j) is stored in a and b remains unchanged."))

(defmethod matrix-sub ((a matrix-double) (b matrix-double))
  (gsl_matrix_sub (entity a) (entity b))
  a)

(defmethod matrix-sub ((a matrix-float) (b matrix-float))
  (gsl_matrix_float_sub (entity a) (entity b))
  a)

(defgeneric matrix-mul-elements (a b)
  (:documentation
   "This function subtracts the elements of matrix b from the elements of matrix a. The
result a(i,j) <- a(i,j) - b(i,j) is stored in a and b remains unchanged. The two
matrices must have the same dimensions."))

(defmethod matrix-mul-elements ((a matrix-double) (b matrix-double))
  (gsl_matrix_mul_elements (entity a) (entity b))
  a)

(defmethod matrix-mul-elements ((a matrix-float) (b matrix-float))
  (gsl_matrix_float_mul_elements (entity a) (entity b))
  a)

(defgeneric matrix-div-elements (a b)
  (:documentation
   "This function multiplies the elements of matrix a by the elements of matrix b. The
result a(i,j) <- a(i,j) * b(i,j) is stored in a and b remains unchanged. The two
matrices must have the same dimensions."))

(defmethod matrix-div-elements ((a matrix-double) (b matrix-double))
  (gsl_matrix_div_elements (entity a) (entity b))
  a)

(defmethod matrix-div-elements ((a matrix-float) (b matrix-float))
  (gsl_matrix_float_div_elements (entity a) (entity b))
  a)

(defgeneric matrix-scale (a x)
  (:documentation
   "This function multiplies the elements of matrix a by the constant factor x. The result
a(i,j) <- a(i,j) * x is stored in a."))

(defmethod matrix-scale ((a matrix-double) x)
  (gsl_matrix_scale (entity a) x)
  a)

(defmethod matrix-scale ((a matrix-float) x)
  (gsl_matrix_float_scale (entity a) x)
  a)

(defgeneric matrix-add-constant (a x)
  (:documentation
   "This function adds the constant value x to the elements of the matrix a. The result
a(i,j) <- a(i,j) + x is stored in a."))

(defmethod matrix-add-constant ((a matrix-double) x)
  (gsl_matrix_add_constant (entity a) x)
  a)

(defmethod matrix-add-constant ((a matrix-float) x)
  (gsl_matrix_float_add_constant (entity a) x)
  a)

(defgeneric matrix-max (m)
  (:documentation
   "This function returns the maximum value in the matrix m."))

(defmethod matrix-max ((m matrix-double))
  (gsl_matrix_max (entity m)))

(defmethod matrix-max ((m matrix-float))
  (gsl_matrix_float_max (entity m)))

(defgeneric matrix-min (m)
  (:documentation
   "This function returns the minimum value in the matrix m."))

(defmethod matrix-min ((m matrix-double))
  (gsl_matrix_min (entity m)))

(defmethod matrix-min ((m matrix-float))
  (gsl_matrix_float_min (entity m)))

(defgeneric matrix-minmax (m)
  (:documentation
   "This function returns the minimum and maximum values in the matrix m, storing
them in min-out and max-out."))

(defmethod matrix-minmax ((m matrix-double))
  (cffi:with-foreign-objects ((min-out :double)
                              (max-out :double))
    (gsl_matrix_minmax (entity m) min-out max-out)
    (values (cffi:mem-ref min-out :double)
            (cffi:mem-ref max-out :double))))

(defmethod matrix-minmax ((m matrix-float))
  (cffi:with-foreign-objects ((min-out :float)
                              (max-out :float))
    (gsl_matrix_float_minmax (entity m) min-out max-out)
    (values (cffi:mem-ref min-out :float)
            (cffi:mem-ref max-out :float))))

(defgeneric matrix-max-index (m)
  (:documentation
   "This function returns the indices of the maximum value in the matrix m, storing them
in imax and jmax. When there are several equal maximum elements then the first
element found is returned, searching in row-major order."))

(defmethod matrix-max-index ((m matrix-double))
  (cffi:with-foreign-objects ((imax :unsigned-int)
                              (jmax :unsigned-int))
    (gsl_matrix_max_index (entity m) imax jmax)
    (values (cffi:mem-ref imax :unsigned-int)
            (cffi:mem-ref jmax :unsigned-int))))

(defmethod matrix-max-index ((m matrix-float))
  (cffi:with-foreign-objects ((imax :unsigned-int)
                              (jmax :unsigned-int))
    (gsl_matrix_float_max_index (entity m) imax jmax)
    (values (cffi:mem-ref imax :unsigned-int)
            (cffi:mem-ref jmax :unsigned-int))))

(defgeneric matrix-min-index (m)
  (:documentation
   "This function returns the indices of the minimum value in the matrix m, storing them
in imin and jmin. When there are several equal minimum elements then the first
element found is returned, searching in row-major order."))

(defmethod matrix-min-index ((m matrix-double))
  (cffi:with-foreign-objects ((imin :unsigned-int)
                              (jmin :unsigned-int))
    (gsl_matrix_min_index (entity m) imin jmin)
    (values (cffi:mem-ref imin :unsigned-int)
            (cffi:mem-ref jmin :unsigned-int))))

(defmethod matrix-min-index ((m matrix-float))
  (cffi:with-foreign-objects ((imin :unsigned-int)
                              (jmin :unsigned-int))
    (gsl_matrix_float_min_index (entity m) imin jmin)
    (values (cffi:mem-ref imin :unsigned-int)
            (cffi:mem-ref jmin :unsigned-int))))

(defgeneric matrix-minmax-index (m)
  (:documentation
   "This function returns the indices of the minimum and maximum values in the matrix
m, storing them in (imin,jmin) and (imax,jmax). When there are several equal min-
imum or maximum elements then the first elements found are returned, searching in
row-major order."))

(defmethod matrix-minmax-index ((m matrix-double))
  (cffi:with-foreign-objects ((imin :unsigned-int)
                              (jmin :unsigned-int)
                              (imax :unsigned-int)
                              (jmax :unsigned-int))
    (gsl_matrix_minmax_index (entity m) imin jmin imax jmax)
    (values (cffi:mem-ref imin :unsigned-int)
            (cffi:mem-ref jmin :unsigned-int)
            (cffi:mem-ref imax :unsigned-int)
            (cffi:mem-ref jmax :unsigned-int))))

(defmethod matrix-minmax-index ((m matrix-float))
  (cffi:with-foreign-objects ((imin :unsigned-int)
                              (jmin :unsigned-int)
                              (imax :unsigned-int)
                              (jmax :unsigned-int))
    (gsl_matrix_float_minmax_index (entity m) imin jmin imax jmax)
    (values (cffi:mem-ref imin :unsigned-int)
            (cffi:mem-ref jmin :unsigned-int)
            (cffi:mem-ref imax :unsigned-int)
            (cffi:mem-ref jmax :unsigned-int))))

(defgeneric matrix-isnull (m)
  (:documentation
   "This functions return t if all the elements of the matrix m are zero,
and nil otherwise."))

(defmethod matrix-isnull ((m matrix-double))
  (= (gsl_matrix_isnull (entity m)) 1))

(defmethod matrix-isnull ((m matrix-float))
  (= (gsl_matrix_float_isnull (entity m)) 1))

(defgeneric matrix-ispos (m)
  (:documentation
   "This functions return t if all the elements of the matrix m are strictly positive,
and nil otherwise."))

(defmethod matrix-ispos ((m matrix-double))
  (= (gsl_matrix_ispos (entity m)) 1))

(defmethod matrix-ispos ((m matrix-float))
  (= (gsl_matrix_float_ispos (entity m)) 1))

(defgeneric matrix-isneg (m)
  (:documentation
   "This functions return t if all the elements of the matrix m are strictly negative,
and nil otherwise."))

(defmethod matrix-isneg ((m matrix-double))
  (= (gsl_matrix_isneg (entity m)) 1))

(defmethod matrix-isneg ((m matrix-float))
  (= (gsl_matrix_float_isneg (entity m)) 1))

(defgeneric matrix-isnonneg (m)
  (:documentation
   "This functions return t if all the elements of the matrix m are non-negative,
and nil otherwise."))

(defmethod matrix-isnonneg ((m matrix-double))
  (= (gsl_matrix_isnonneg (entity m)) 1))

(defmethod matrix-isnonneg ((m matrix-float))
  (= (gsl_matrix_float_isnonneg (entity m)) 1))

(defgeneric matrix-equal (a b)
  (:documentation
   "This function returns t if the matrices a and b are equal (by comparison of element
values) and nil otherwise."))

(defmethod matrix-equal ((a matrix-double) (b matrix-double))
  (= (gsl_matrix_equal (entity a) (entity b)) 1))

(defmethod matrix-equal ((a matrix-float) (b matrix-float))
  (= (gsl_matrix_float_equal (entity a) (entity b)) 1))

(defun last1 (lst)
  (car (last lst)))

(defun flatten (x)
  (labels ((rec (x acc)
             (cond ((null x) acc)
                   ((atom x) (cons x acc))
                   (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))

(defgeneric matrix-set-sequence (m n1 n2 seq)
  (:documentation
   "This function sets each element of the matrix m to each element of the sequence
seq respectively."))

(defmethod matrix-set-sequence ((m matrix-double) n1 n2 seq)
  (let ((idx 0))
    (dotimes (i n1 m)
      (dotimes (j n2)
        (gsl_matrix_set (entity m) i j (elt seq idx))
        (setf idx (1+ idx))))))

(defmethod matrix-set-sequence ((m matrix-float) n1 n2 seq)
  (let ((idx 0))
    (dotimes (i n1 m)
      (dotimes (j n2)
        (gsl_matrix_float_set (entity m) i j (elt seq idx))
        (setf idx (1+ idx))))))

(defgeneric matrix-set-2darray (m n1 n2 2darray)
  (:documentation
   "This function sets each element of the matrix m to each element of the 2 dimensions
array respectively."))

(defmethod matrix-set-2darray ((m matrix-double) n1 n2 2darray)
  (dotimes (i n1 m)
    (dotimes (j n2)
      (gsl_matrix_set (entity m) i j (aref 2darray i j)))))

(defmethod matrix-set-2darray ((m matrix-float) n1 n2 2darray)
  (dotimes (i n1 m)
    (dotimes (j n2)
      (gsl_matrix_float_set (entity m) i j (aref 2darray i j)))))

;;; Allocate an aline of (struct gsl-matrix) in foeign heap, and return a pointer to it.
(defun make-matrix (n1 n2 &key (initial-element nil) (initial-contents nil) (ctype :double))
  "This function creates a matrix of size n1 rows by n2 columns, returning a pointer
to a newly initialized matrix struct. A new block is allocated for the elements of
the matrix, and stored in the block component of the matrix struct. The block is
owned by the matrix, and will be deallocated when the matrix is deallocated.
The memory is allocated using gsl-matrix-alloc, so it can be passed to foreign
functions which gsl-matrix-free, or released using free-alien."
  (let ((m (matrix-calloc n1 n2 :ctype ctype)))
    (cond ((not (null initial-element))
           (matrix-set-all m initial-element))
          ((not (null initial-contents))
           (cond ((consp initial-contents)
                  (matrix-set-sequence m n1 n2 (flatten initial-contents)))
                 ((and (arrayp initial-contents)
                       (= (length (array-dimensions initial-contents)) 1))
                  (matrix-set-sequence m n1 n2 initial-contents))
                 ((and (arrayp initial-contents)
                       (= (length (array-dimensions initial-contents)) 2))
                  (matrix-set-2darray m n1 n2 initial-contents))))
          (t m))))

(defgeneric matrix-to-2darray (m n1 n2)
  (:documentation
   "This function return the 2darray whose elements is equal to elements of the matrix."))

(defmethod matrix-to-2darray ((m matrix-double) n1 n2)
  (let ((acc (make-array (list n1 n2) :element-type 'double-float)))
    (dotimes (i n1 acc)
      (dotimes (j n2)
        (setf (aref acc i j) (gsl_matrix_get (entity m) i j))))))

(defmethod matrix-to-2darray ((m matrix-float) n1 n2)
  (let ((acc (make-array (list n1 n2) :element-type 'single-float)))
    (dotimes (i n1 acc)
      (dotimes (j n2)
        (setf (aref acc i j) (gsl_matrix_float_get (entity m) i j))))))