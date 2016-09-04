;;; cl-gsl/gsl.lisp

(cl:in-package "GSL")

;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 3.0.10
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.


(cffi:defctype size_t :unsigned-int)

(cffi:defcstruct gsl_rng_type
	(name :string)
	(max :unsigned-long)
	(min :unsigned-long)
	(size :unsigned-int)
	(set :pointer)
	(get :pointer)
	(get_double :pointer))

(cffi:defcstruct gsl_rng
	(type :pointer)
	(state :pointer))

(cffi:defcvar ("gsl_rng_borosh13" gsl_rng_borosh13)
 :pointer)

(cffi:defcvar ("gsl_rng_coveyou" gsl_rng_coveyou)
 :pointer)

(cffi:defcvar ("gsl_rng_cmrg" gsl_rng_cmrg)
 :pointer)

(cffi:defcvar ("gsl_rng_fishman18" gsl_rng_fishman18)
 :pointer)

(cffi:defcvar ("gsl_rng_fishman20" gsl_rng_fishman20)
 :pointer)

(cffi:defcvar ("gsl_rng_fishman2x" gsl_rng_fishman2x)
 :pointer)

(cffi:defcvar ("gsl_rng_gfsr4" gsl_rng_gfsr4)
 :pointer)

(cffi:defcvar ("gsl_rng_knuthran" gsl_rng_knuthran)
 :pointer)

(cffi:defcvar ("gsl_rng_knuthran2" gsl_rng_knuthran2)
 :pointer)

(cffi:defcvar ("gsl_rng_knuthran2002" gsl_rng_knuthran2002)
 :pointer)

(cffi:defcvar ("gsl_rng_lecuyer21" gsl_rng_lecuyer21)
 :pointer)

(cffi:defcvar ("gsl_rng_minstd" gsl_rng_minstd)
 :pointer)

(cffi:defcvar ("gsl_rng_mrg" gsl_rng_mrg)
 :pointer)

(cffi:defcvar ("gsl_rng_mt19937" gsl_rng_mt19937)
 :pointer)

(cffi:defcvar ("gsl_rng_mt19937_1999" gsl_rng_mt19937_1999)
 :pointer)

(cffi:defcvar ("gsl_rng_mt19937_1998" gsl_rng_mt19937_1998)
 :pointer)

(cffi:defcvar ("gsl_rng_r250" gsl_rng_r250)
 :pointer)

(cffi:defcvar ("gsl_rng_ran0" gsl_rng_ran0)
 :pointer)

(cffi:defcvar ("gsl_rng_ran1" gsl_rng_ran1)
 :pointer)

(cffi:defcvar ("gsl_rng_ran2" gsl_rng_ran2)
 :pointer)

(cffi:defcvar ("gsl_rng_ran3" gsl_rng_ran3)
 :pointer)

(cffi:defcvar ("gsl_rng_rand" gsl_rng_rand)
 :pointer)

(cffi:defcvar ("gsl_rng_rand48" gsl_rng_rand48)
 :pointer)

(cffi:defcvar ("gsl_rng_random128_bsd" gsl_rng_random128_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random128_glibc2" gsl_rng_random128_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random128_libc5" gsl_rng_random128_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_random256_bsd" gsl_rng_random256_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random256_glibc2" gsl_rng_random256_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random256_libc5" gsl_rng_random256_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_random32_bsd" gsl_rng_random32_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random32_glibc2" gsl_rng_random32_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random32_libc5" gsl_rng_random32_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_random64_bsd" gsl_rng_random64_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random64_glibc2" gsl_rng_random64_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random64_libc5" gsl_rng_random64_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_random8_bsd" gsl_rng_random8_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random8_glibc2" gsl_rng_random8_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random8_libc5" gsl_rng_random8_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_random_bsd" gsl_rng_random_bsd)
 :pointer)

(cffi:defcvar ("gsl_rng_random_glibc2" gsl_rng_random_glibc2)
 :pointer)

(cffi:defcvar ("gsl_rng_random_libc5" gsl_rng_random_libc5)
 :pointer)

(cffi:defcvar ("gsl_rng_randu" gsl_rng_randu)
 :pointer)

(cffi:defcvar ("gsl_rng_ranf" gsl_rng_ranf)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlux" gsl_rng_ranlux)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlux389" gsl_rng_ranlux389)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlxd1" gsl_rng_ranlxd1)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlxd2" gsl_rng_ranlxd2)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlxs0" gsl_rng_ranlxs0)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlxs1" gsl_rng_ranlxs1)
 :pointer)

(cffi:defcvar ("gsl_rng_ranlxs2" gsl_rng_ranlxs2)
 :pointer)

(cffi:defcvar ("gsl_rng_ranmar" gsl_rng_ranmar)
 :pointer)

(cffi:defcvar ("gsl_rng_slatec" gsl_rng_slatec)
 :pointer)

(cffi:defcvar ("gsl_rng_taus" gsl_rng_taus)
 :pointer)

(cffi:defcvar ("gsl_rng_taus2" gsl_rng_taus2)
 :pointer)

(cffi:defcvar ("gsl_rng_taus113" gsl_rng_taus113)
 :pointer)

(cffi:defcvar ("gsl_rng_transputer" gsl_rng_transputer)
 :pointer)

(cffi:defcvar ("gsl_rng_tt800" gsl_rng_tt800)
 :pointer)

(cffi:defcvar ("gsl_rng_uni" gsl_rng_uni)
 :pointer)

(cffi:defcvar ("gsl_rng_uni32" gsl_rng_uni32)
 :pointer)

(cffi:defcvar ("gsl_rng_vax" gsl_rng_vax)
 :pointer)

(cffi:defcvar ("gsl_rng_waterman14" gsl_rng_waterman14)
 :pointer)

(cffi:defcvar ("gsl_rng_zuf" gsl_rng_zuf)
 :pointer)

(cffi:defcvar ("gsl_rng_default" gsl_rng_default)
 :pointer)

(cffi:defcvar ("gsl_rng_default_seed" gsl_rng_default_seed)
 :unsigned-long)

(cffi:defcfun ("gsl_rng_alloc" gsl_rng_alloc) :pointer
  (t_arg0 :pointer))

(cffi:defcfun ("gsl_rng_memcpy" gsl_rng_memcpy) :int
  (dest :pointer)
  (src :pointer))

(cffi:defcfun ("gsl_rng_clone" gsl_rng_clone) :pointer
  (r :pointer))

(cffi:defcfun ("gsl_rng_free" gsl_rng_free) :void
  (r :pointer))

(cffi:defcfun ("gsl_rng_set" gsl_rng_set) :void
  (r :pointer)
  (seed :unsigned-long))

(cffi:defcfun ("gsl_rng_max" gsl_rng_max) :unsigned-long
  (r :pointer))

(cffi:defcfun ("gsl_rng_min" gsl_rng_min) :unsigned-long
  (r :pointer))

(cffi:defcfun ("gsl_rng_name" gsl_rng_name) :string
  (r :pointer))

(cffi:defcfun ("gsl_rng_fread" gsl_rng_fread) :int
  (stream :pointer)
  (r :pointer))

(cffi:defcfun ("gsl_rng_fwrite" gsl_rng_fwrite) :int
  (stream :pointer)
  (r :pointer))

(cffi:defcfun ("gsl_rng_size" gsl_rng_size) :unsigned-int
  (r :pointer))

(cffi:defcfun ("gsl_rng_state" gsl_rng_state) :pointer
  (r :pointer))

(cffi:defcfun ("gsl_rng_print_state" gsl_rng_print_state) :void
  (r :pointer))

(cffi:defcfun ("gsl_rng_env_setup" gsl_rng_env_setup) :pointer)

(cffi:defcfun ("gsl_rng_get" gsl_rng_get) :unsigned-long
  (r :pointer))

(cffi:defcfun ("gsl_rng_uniform" gsl_rng_uniform) :double
  (r :pointer))

(cffi:defcfun ("gsl_rng_uniform_pos" gsl_rng_uniform_pos) :double
  (r :pointer))

(cffi:defcfun ("gsl_rng_uniform_int" gsl_rng_uniform_int) :unsigned-long
  (r :pointer)
  (n :unsigned-long))


