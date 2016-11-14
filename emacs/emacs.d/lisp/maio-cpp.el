(defun vr-c++-looking-at-lambda_as_param ()
  "Return t if text after point matches '[...](' or '[...]{'"
  (looking-at ".*[,(][ \t]*\\[[^]]*\\][ \t]*[({][^}]*?[ \t]*[({][^}]*?$"))

(defun vr-c++-looking-at-lambda_in_uniform_init ()
  "Return t if text after point matches '{[...](' or '{[...]{'"
  (looking-at ".*{[ \t]*\\[[^]]*\\][ \t]*[({][^}]*?[ \t]*[({][^}]*?$"))

(defun vr-c++-indentation-examine (langelem looking-at-p)
  (and (equal major-mode 'c++-mode)
	   (ignore-errors
		 (save-excursion
		   (goto-char (c-langelem-pos langelem))
		   (funcall looking-at-p)))))

(use-package google-c-style)

(defun vr-c++-indentation-setup ()
  (require 'google-c-style)
  (google-set-c-style)

  (c-set-offset
   'block-close
   (lambda (langelem)
	 (if (vr-c++-indentation-examine
		  langelem
		  #'vr-c++-looking-at-lambda_in_uniform_init)
		 '-
	   0)))

  (c-set-offset
   'statement-block-intro
   (lambda (langelem)
	 (if (vr-c++-indentation-examine
		  langelem
		  #'vr-c++-looking-at-lambda_in_uniform_init)
		 0
	   '+)))

  (defadvice c-lineup-arglist (around my activate)
	"Improve indentation of continued C++11 lambda function opened as argument."
	(setq ad-return-value
		  (if (vr-c++-indentation-examine
			   langelem
			   #'vr-c++-looking-at-lambda_as_param)
			  0
			ad-do-it))))

(defun maio-cpp-settings ()
  (vr-c++-indentation-setup)
  (setq indent-tabs-mode t
		whitespace-style '(face
						   lines-tail
						   trailing
						   indentation:tab
						   space-before-tab)))

(add-hook 'c++-mode-hook 'maio-cpp-settings)

(use-package smart-tabs-mode
  :defer t
  :config
  (smart-tabs-insinuate 'c++))

(provide 'maio-cpp)
