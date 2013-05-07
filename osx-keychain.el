(defun os-x-version ()
  "Returns whether we are running OS X Lion of Mountain Lion"
  (let ((major-version-number (substring (shell-command-to-string "sw_vers -productVersion") 0 5)))
    (cond
     ((string-equal major-version-number "10.7.") 'os-x-lion)
     ((string-equal major-version-number "10.8.") 'os-x-mountain-lion))))

(defun find-keychain-password-mountain-lion (type account server)
  (condition-case nil
      (first
       (process-lines
	"security" (concat "find-" type "-password")
	"-w" ; display only the password to stdout
	"-a" account
	"-s" server))
    ; TODO: handle case when keychain does not return an entry
    (error "")))

(defun find-keychain-password-lion (type account server)
  (let ((password-line (first
			(process-lines
			 "security"  (concat "find-" type "-password")
			 "-g" ; display only the password to stdout
			 "-a" account
			 "-s" server
			 ))))
    (string-match "password: \"\\(.*\\)\"" password-line)
    (match-string 1 password-line)))

(defun find-keychain-password (type account server)
  (let ((os-x-version (os-x-version)))
    (cond
     ((eq os-x-version 'os-x-lion)
      (find-keychain-password-lion type account server))
     ((eq os-x-version 'os-x-mountain-lion)
      (find-keychain-password-mountain-lion type account server)))))

(defun find-keychain-internet-password (account server)
  (find-keychain-password "internet" account server))

(defun find-keychain-generic-password (account server)
  (find-keychain-password "generic" account server))
