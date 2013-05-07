# osx-keychain.el
`osx-keychain.el` allows you to access OS X Keychain entries using Emacs. This allows one to store passwords used by Emacs packages such as [erc](http://www.emacswiki.org/cgi-bin/wiki/ERC) and [emacs-jabber](http://emacs-jabber.sourceforge.net/) safely in OS X Keychain.
## Installation
TODO
## Example usage
Here is how you might use `osx-keychain.el` to configure emacs-jabber:
```
(setq jabber-account-list
      `(("user@example.com"
	 (:network-server . "jabber.example.com")
         (:connection-type . ssl)
	 (:password . ,(find-keychain-internet-password "user@example.com" "jabber.example.com")))))
```