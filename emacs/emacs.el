;;;elispプログラムを置くところへパスを通す
(setq load-path (cons "~/mylib/emacs/" load-path))


(defvar matlab:current-system
  (nth 2 (split-string system-configuration "-")))

;;; switch variables
(defvar matlab:use-mew		nil) ;; set this t to use Mew
(defvar matlab:use-wl		nil) ;; set this t to use Wanderlust

;;;
;;; Key customize
;;;
(global-set-key [(control h)]	'delete-backward-char) ;バックスペース
(global-set-key [(meta g)]	'goto-line) 
(global-set-key [(control space)] 'set-mark-command) 
(global-set-key [?\S-\ ] 'toggle-input-method) ; shift-spaceで入力変換

;; emacsの終了動作C-xC-cを無効化する
;;  M-x kill-emacs で終了させる
(global-unset-key "\C-x\C-c")


;;;
;;; Language
;;;
(set-language-environment "Japanese")

;;; coding system
(set-default-coding-systems	'utf-8)
(set-buffer-file-coding-system	'utf-8)
(set-terminal-coding-system	'utf-8)
(setq default-file-name-coding-system 'utf-8)
(setq auto-coding-functions nil)

;;;
;;; Japanese Input Method
;;;
;; Anthy 
;;
;; (when (string-match "linux" system-configuration)
;;  (load-library "anthy")
;;  (or 
;;   (and (assoc "japanese-egg-anthy" input-method-alist)	; egg-anthy
;; 	(require 'egg)
;; 	(setq enable-double-n-syntax		t)
;; 	(setq egg-conversion-wrap-select	t
;; 	      egg-conversion-auto-candidate-menu 2)
;; 	(setq default-input-method "japanese-egg-anthy"))
;;   (and (assoc "japanese-anthy" input-method-alist)	; anthy
;; 	(setq default-input-method 'japanese-anthy))))
;;anthyのタイムアウト時間を短くする
;; (load-library "anthy")
;; (if (>= emacs-major-version 23)
;;    (setq anthy-accept-timeout 1))  

;;ibus
;; ibus-mozcを利用するためには ibus-elをインストールしておく必要有り
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("limegreen" "white" "blue"))
(global-set-key [?\S-\ ] 'ibus-toggle)

;; mozc
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")



;;;
;;; highlight
;;;
(require 'font-lock)
(global-font-lock-mode t)
;リージョンハイライト
(transient-mark-mode t)
;括弧の対応付け
(require 'paren)
(show-paren-mode t)
;;カーソルの行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "#333333"))
    (((class color)
      (background light))
     (:background "light gray"))
     (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;;(setq hl-line-face 'underline) ;; under line 
(global-hl-line-mode)
;rubyで対応するendをハイライト
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)


;;;
;;; TeX
;;;
(if (locate-library "auctex")
    (load "auctex.el" nil t t))
;; (setq TeX-japanese-process-input-coding-system  'japanese-iso-8bit
;;       TeX-japanese-process-output-coding-system 'iso-2022-jp
;;       LaTeX-version			"2e"
;;       japanese-LaTeX-default-style	"jarticle"
;;       TeX-default-mode			'japanese-latex-mode
;;       TeX-force-default-mode		t
;;       LaTeX-top-caption-list		'("table" "tabular")
;;       TeX-command-default		"pLaTeX"
;;       TeX-parse-self			t
;;       japanese-LaTeX-command-default	"pLaTeX"
;;       LaTeX-float			"tn"
;;       LaTeX-figure-label		"fig:"
;;       LaTeX-table-label			"tab:"
;;       LaTeX-section-label		"sec:")
(eval-after-load "auctex"
  '(when window-system
     (require 'font-latex)))
;;; bibtex
(setq bib-bibtex-env-variable		"TEXMFHOME")
(autoload 'turn-on-bib-cite "bib-cite")
(add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
;;; reftex
(setq reftex-texpath-environment-variables	'("TEXMFHOME")
      reftex-bibpath-environment-variables	'("~/texmf//")
      reftex-plug-into-AUCTeX			t
      reftex-label-alist
      '(("figure"       ?F "fig:" "\\figref{%s}" caption nil)
	("figure*"      ?F nil nil caption)
	("table"        ?T "tab:" "\\tabref{%s}" caption nil)
	("table*"       ?T nil nil caption)))
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)   ; with AUCTeX LaTeX mode
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)   ; with AUCTeX LaTeX mode
;;;ビューソフトをpxdviにする
(setq TeX-output-view-style '(("^dvi$" "." "pxdvi '%d'")))


;;;
;;; Mouse Wheel
;;;
(mwheel-install)
(setq mouse-wheel-follow-mouse t)

;;;
;;; Message User Agent
;;;
;; Mew
;;
(when matlab:use-mew
  (autoload 'mew	"mew" nil t)
  (autoload 'mew-send	"mew" nil t)
  (if (file-exists-p (expand-file-name "~/.mew.el"))
    (load (expand-file-name "~/.mew.el") nil t nil))
  )

;; Wanderlust
;;
(when matlab:use-wl
  (autoload 'wl		"wl" "wanderlust" t)
  (setq smtp-local-domain	"matlab.nitech.ac.jp"
	wl-smtp-posting-server	"mail"			;; smtp server
	elmo-imap4-default-server	"mail"		;; imap server
	wl-biff-check-folder-list	'("%inbox")
	wl-from			(concat (user-login-name) "@matlab.nitech.ac.jp")
	wl-message-id-domain	"matlab.nitech.ac.jp"
	wl-use-ldap		t
	wl-ldap-server		"mats.matlab.nitech.ac.jp"
	wl-ldap-base		"dc=matlab,dc=nitech,dc=ac,dc=jp"
	wl-draft-reply-buffer-style 'keep
	wl-draft-folder		"..Draft"
	wl-trash-folder		"..Trash"
	wl-queue-folder		"..queue"
	wl-interactive-send	t)
  )
(when (string-match "solaris" system-configuration)
	(setq ldap-search-program-arguments '("-L" "-T")))

;;; SEMI (for wl etc)
(setq mail-self-blind		t
      mime-edit-split-message   nil
      Mime-header-accept-quoted-encoded-words t
      mime-view-ignored-field-list
      '(".*Received:" ".*Path:" ".*Id:" "^References:"
        "^Replied:" "^Errors-To:" "^Lines:" ".*Host:" "^Xref:"
        "^Precedence:" "^Status:" "^X-VM-.*:"
        "^Mail-Reply-To:" "^Mail-Followup-To:" "^In-Reply-To:" "^X-*"
        "^Posted:" "^Mailing-List:" "^Delivered-To:" "^Date:"
        "^Content-Transfer-Encoding:" "^Message-Id:"
        "^List-Help:" "^List-Post:" "^List-Subscribe:"
        "^List-Unsubscribe:" "^List-Archive:"
        )
      mime-view-visible-field-list
      '("^Dnas.*:" "^Message-Id:"
        "^User-Agent:" "^X-Mailer:" "^X-Newsreader:" "^X-MimeOLE:" "^X-Emacs:"
        "^Content-Type:" "^X-Dispatcher:" "^X-Face:" "^X-Face-.*:"))

;;;
;;; tramp
;;;
(if (locate-library "tramp")
   (require 'tramp))

;;;
;;; emacsclient
;;;
(server-start)


;; ;;;elispの中のファイルを読み込む
;; (require 'dabbrev-expand-multiple)
;; (global-set-key "\M-/" 'dabbrev-expand-multiple)
;; (setq outline-minor-mode-prefix "\M-o")


;;;
;;;ツールバーを非表示
;;;
(tool-bar-mode 0)
(menu-bar-mode 0)



;;
;;Emacsのバージョンが23のときテーマ適用
;;
(if (>= emacs-major-version 23)
      (progn
	(setq load-path (cons "~/mylib/emacs/color-theme-6.6.0" load-path))
	(require 'color-theme)
	(color-theme-initialize)
	(color-theme-dark-laptop)
	)
)

;起動時にscratchバッファ
(setq inhibit-startup-screen t)

;;compizとか使用時のemacsの透過具合
(modify-all-frames-parameters 
 (list (cons 'alpha '(95 95 95 95))))


; Emacs23 用フォンと設定
;; (cond ((string-match "^23\." emacs-version)
(cond (window-system
       (set-default-font "Source Code Pro-10")
       (set-fontset-font (frame-parameter nil 'font)
			 'japanese-jisx0208
			 '("うずらフォント" . "unicode-bmp"))
));)				
;; 新規フレームのデフォルト設定
;;フォントの設定より後ろに書く必要アリ
(modify-all-frames-parameters (list (assq 'font (frame-parameters))))


;;
;; iswitchb-mode
;;
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)
(setq iswitchb-buffer-ignore
      '("^ "
	"\*GNU Emacs\*"
	"\*Buffer List\*"
	"\*Messages\*"
	"\*Compile-Log\*"
	"\*Completions\*"
	"\*auto-install"
	"\*ENB All notes\*"
	"\*Evernote"
	"\*trace of SMTP session to mail\*"
	"\*elmo-split\*"
	"\*GTAGS"
	"\.ipa"))


;;
;;バックアップファイルを~/.emacsbacksに吐かせる
(setq make-backup-files t)
(setq backup-directory "~/.emacsbacks")
(if (and (boundp 'backup-directory)
         (not (fboundp 'make-backup-file-name-original)))
    (progn
      (fset 'make-backup-file-name-original
            (symbol-function 'make-backup-file-name))
      (defun make-backup-file-name (filename)
        (if (and (file-exists-p (expand-file-name backup-directory))
                 (file-directory-p (expand-file-name backup-directory)))
            (concat (expand-file-name backup-directory) 
                    "/" (file-name-nondirectory filename))
          (make-backup-file-name-original filename)))))

;;
;;ruby
;;
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;;emacs起動時にhs-minor-modeを自動起動
;;rubyやlispの時はまだ未対応
;; (add-hook 'c-mode-common-hook
;; '(lambda()
;; (hs-minor-mode 1))) 
(load-library "hideshow")
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;;rubyに対応させる
(add-hook 'ruby-mode-hook
          '(lambda()
            (hs-minor-mode 1)))
(let ((ruby-mode-hs-info
       '(ruby-mode
          "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
          "end"
          "#"
          ruby-move-to-block
          nil)))
  (if (not (member ruby-mode-hs-info hs-special-modes-alist))
      (setq hs-special-modes-alist
            (cons ruby-mode-hs-info hs-special-modes-alist))))
;; 隠した(hide)行は、isearchの対象にしない(outlineモードにも影響)
(setq search-invisible nil) ;; 「'open」or「t」
;; hs-minor-modeのキーバインド達
(define-key hs-minor-mode-map (kbd "C-c C-t") 'hs-toggle-hiding)
(define-key hs-minor-mode-map (kbd "C-c C-a C-h") 'hs-hide-all)
(define-key hs-minor-mode-map (kbd "C-c C-a C-s") 'hs-show-all)


;;タグジャンプする際にTAGSファイルがなければTAGSファイルを作成してくれる。
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))


;;
;;flymake
;;
(require 'flymake)
(require 'popup)
(add-hook 'c-mode-common-hook '(lambda () (flymake-mode t)))
(defun my-flymake-popup-error ()
  (interactive)
  (popup-tip (mapconcat '(lambda (line-err-info)
			   (format "[%s] %s"
				   (flymake-ler-line line-err-info)
				   (flymake-ler-text line-err-info)))
			(car (flymake-find-err-info flymake-err-info
						    (flymake-current-line-no)))
			"\n")))
(global-set-key (kbd "C-c SPC") 'my-flymake-popup-error)
;flymake時警告は青色にする
(defun flymake-parse-line (line)
  "Parse LINE to see if it is an error or warning.
Return its components if so, nil otherwise."
  (let ((raw-file-name nil)
	(line-no 0)
	(err-type "e")
	(err-text nil)
	(patterns flymake-err-line-patterns)
	(matched nil))
    (while (and patterns (not matched))
      (when (string-match (car (car patterns)) line)
	(let* ((file-idx (nth 1 (car patterns)))
	       (line-idx (nth 2 (car patterns))))

	  (setq raw-file-name (if file-idx (match-string file-idx line) nil))
	  (setq line-no       (if line-idx (string-to-number (match-string line-idx line)) 0))
	  (setq err-text      (if (> (length (car patterns)) 4)
				  (match-string (nth 4 (car patterns)) line)
				(flymake-patch-err-text (substring line (match-end 0)))))
	  (or err-text (setq err-text "<no error text>"))
	  (if (and err-text (string-match "[wW]arning\\|警告" err-text))
	      (setq err-type "w")
	    )
	  (flymake-log 3 "parse line: file-idx=%s line-idx=%s file=%s line=%s text=%s" file-idx line-idx
		       raw-file-name line-no err-text)
	  (setq matched t)))
      (setq patterns (cdr patterns)))
    (if matched
	(flymake-ler-make-ler raw-file-name line-no err-type err-text)
      ())))
;;; for ruby-mode
;; flymake-ruby
(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
         (local-file (file-relative-name temp-file
					 (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.rb$" flymake-ruby-init))
;; (add-to-list 'flymake-err-line-patterns '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3))
(add-hook 'ruby-mode-hook '(lambda ()
			     (if (not (null buffer-file-name))
				 (flymake-mode t))))

;(setq flymake-run-in-place nil);trampの時は無効に
;; flymake を使えない場合をチェック
(defadvice flymake-can-syntax-check-file
  (after my-flymake-can-syntax-check-file activate)
  (cond
   ((not ad-return-value))
   ;; tramp 経由であれば、無効
   ((and (fboundp 'tramp-list-remote-buffers)
         (memq (current-buffer) (tramp-list-remote-buffers)))
    (setq ad-return-value nil))
   ;; 書き込み不可ならば、flymakeは無効
   ((not (file-writable-p buffer-file-name))
    (setq ad-return-value nil))
   ;; flymake で使われるコマンドが無ければ無効
   ((let ((cmd (nth 0 (prog1
                          (funcall (flymake-get-init-function buffer-file-name))
                        (funcall (flymake-get-cleanup-function buffer-file-name))))))
      (and cmd (not (executable-find cmd))))
    (setq ad-return-value nil))
   ))



;;
;; Evernote-mode
;;
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional
(require 'evernote-mode)
(global-set-key "\C-cec" 'evernote-create-note)
(global-set-key "\C-ceo" 'evernote-open-note)
(global-set-key "\C-ces" 'evernote-search-notes)
(global-set-key "\C-ceS" 'evernote-do-saved-search)
(global-set-key "\C-cew" 'evernote-write-note)
(global-set-key "\C-cep" 'evernote-post-region)
(global-set-key "\C-ceb" 'evernote-browser)


;;
;; auto-complete-mode
;;
;; (add-to-list 'load-path ac-dir)
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(add-to-list 'ac-dictionary-directories "~/elisp/auto-complete-1.3.1/dict/")
(global-auto-complete-mode t)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;;(define-key ac-completing-map (kbd “TAB”) ‘ac-complete)
(setq ac-dwim t)
;; autocomplete


;;
;;howm
;; 	
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring)) 	
;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)
;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)
;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)
;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)
;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))
;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))
 ;; メニューを自動更新しない
(setq howm-menu-refresh-after-save nil)
;; 下線を引き直さない
(setq howm-refresh-after-save nil)

;;=================== howmここまで ============================


;;
;; org-mode
;;
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-font-lock);org-modeのバッファはfont-lock-mode


;;============== emacs-nav ==============
;emacs用のファイルブラウザ
(add-to-list 'load-path "~/mylib/emacs/emacs-nav-49")
(require 'nav)
(setq nav-split-window-direction 'vertical) ;; 分割したフレームを垂直に並べる
(global-set-key "\C-x\C-d" 'nav-toggle)     ;; C-x C-d で nav をトグル
; ?を打つとヘルプがでる


;;
;;=========================Web系============================
;;
;; php-mode
;;
(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
  '(lambda ()
     (setq php-manual-path "~/Downloads/php-chunked-xhtml");phpマニュアルへのパス
     (setq php-manual-url "http://www.phppro.jp/phpmanual/")
     (setq tab-width 2)
     (setq indent-tabs-mode t))
)
;;
;; CSS editing mode
;; cssの色付け、タブによるプロパティ名の補完
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)
;;
;; javascript mode
;;
(add-to-list 'auto-mode-alist (cons "\\.js\\'" 'javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq js-indent-level 4)
;;
;; MMM mode
;;
;;
;;mmm-modeはversion24以降しか使えない
(if (>= emacs-major-version 24)
      (progn
(add-to-list 'load-path "~/mylib/emacs/mmm-mode-0.5.1")
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face nil)
;; for php-mode in html-helper-mode
(mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
(mmm-add-classes
  '((html-php
  :submode php-mode
  :front "<\\?\\(php\\)?"
  :back "\\?>")))
  (add-to-list 'auto-mode-alist '("\\.php?\\'" . html-helper-mode))
	)
)

(defvar html-helper-new-buffer-template
  '("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"
    "<html>\n"
    "<head>\n"
    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
    "<title>" p "</title>\n"
    "<link rel=\"stylesheet\"  href=\"\" type=\"text/css\">\n"
    "<script type=\"text/javascript\" src=\"\"></script>\n"
    "</head>\n"
    "<body>\n"
    "\n</body>\n</html>\n")
  "*Template for new buffers, inserted by html-helper-insert-new-buffer-strings if
html-helper-build-new-buffer is set to t")
