(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;; 普通设置
(custom-set-variables
  '(custom-enabled-themes (quote (deeper-blue))))
(custom-set-faces)
(setq frame-title-format "emacs@%b")                    ; 在标题栏显示 buffer 的名字
(setq inhibit-startup-message t)                        ; 关闭起动时闪屏
(setq visible-bell t)                                   ; 关闭出错时的提示声
(setq make-backup-files nil)                            ; 不产生备份文件
(setq auto-save-default nil)                            ; 不产生自动保存文件
(recentf-mode 1)                                        ; 最近打开文件列表
(setq default-major-mode 'c-mode)                       ; 一打开就起用 text 模式
(setq default-directory "~/")
(global-font-lock-mode t)                               ; 语法高亮
(global-visual-line-mode t)                             ; 自动断行
(auto-image-file-mode t)                                ; 打开图片显示功能
(setq mouse-yank-at-point t)                            ; 鼠标中键粘贴
(fset 'yes-or-no-p 'y-or-n-p)                           ; 以 y/n 代表 yes/no
(column-number-mode t)                                  ; 显示列号
(electric-pair-mode 1)                                  ; 自动添加括号和引号
(show-paren-mode t)                                     ; 显示括号匹配
(setq show-paren-style 'expression)                     ; 高亮整个括号
(display-time-mode 1)                                   ; 显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode -1)                                      ; 去掉工具栏
(scroll-bar-mode nil)                                   ; 去掉滚动条
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(setq x-select-enable-clipboard t)                      ; 和外部程序共用剪贴板
(cua-mode 1)                                            ; 复制粘贴快捷键

; (defun fontify-frame (frame)
;   (interactive)
;   (if window-system
;     (progn
;       (if (> (x-display-pixel-height) 768)
;         (set-frame-parameter frame 'font "Yahei Consolas Hybrid 13")
;         (set-frame-parameter frame 'font "Yahei Consolas Hybrid 8"))
;       )
;     )
;   )
; (fontify-frame nil)
; (push 'fontify-frame after-make-frame-functions)

;; 环境变量
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
          (split-string-and-unquote path ":")
          exec-path))
  )

;; Maxima
(add-to-list 'load-path "/Applications/homebrew/Cellar/maxima/5.32.1/share/maxima/5.32.1/emacs")
(autoload 'imaxima "imaxima" "Frontend for maxima" t)

:; 插件列表
(setq package-list '(evil))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Evil
(setq evil-toggle-key "C-`") ;更改切换键使之不与 cua 冲突
(evil-mode 1)
(loop for (mode . state) in '((inferior-octave-mode . emacs))
      do (evil-set-initial-state mode state))
