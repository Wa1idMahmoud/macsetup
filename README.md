# Personal Mac Dev Setup 💻

---

## Description

On many occasions, I had to change laptops, which meant
I had to install **everything** again from scratch.

_So_ I wrote this basic script to automate the process

## Prerequisite

Install x-code which contains dev env for mac:

[Apple Command Line Tools](https://developer.apple.com/download/all/?q=command%20line%20tools)

---

## How to run the script

``` bash
chmod 755 setup.sh
./setup.sh
```

## Still TO DO

- [ ] Automate dot files
- [ ] Store secrets ie .aws, cers
- [ ] Hidden script to move/apply secrets
- [ ] Settings for vscode

Google Chrome:
Ensure to sign in and turn on sync in Chrome
to keep your browser customizations - bookmarks, extensions etc

Vs Code Sync:
You can turn on Settings Sync using the Turn On Settings Sync... entry in the Manage gear menu at the bottom of the Activity Bar.

[VS Code Settings Sync Documentation](https://code.visualstudio.com/docs/editor/settings-sync)

### To add in `.zshrc`

``` bash
plugins=(z, zsh-autosuggestions)
eval "$(starship init zsh)"
```

---

## Github machine setup:

### SSH:

To Generate an SSH key:

``` bash 
ssh-keygen
cat ~/.ssh/id_rsa.pub | pbcopy
```  

## GPG

If you are on version 2.1.17 or greater, paste the text below to generate a GPG key pair.

``` bash
    gpg --full-generate-key
```

Use the gpg --list-secret-keys --keyid-format=long command to list the long form of the GPG keys

``` bash
    gpg --list-secret-keys --keyid-format=long
```

Copy Id after the `sec 4096R/`

``` bash
    gpg --armor --export **GPG key ID**
```
---

## DEV Links

Daily websites I use:

- [Crontab Guru](https://crontab.guru/#*_*_*_*_*)

- [CIDR IP ADDRESS](https://cidr.xyz/)

- [DevDocs](https://devdocs.io/)

- [ShellCheck](https://www.shellcheck.net/)

- [JSONLint](https://jsonlint.com/)

- [YAMLLint](https://www.yamllint.com/)

- [CyberChef](https://gchq.github.io/CyberChef/)

- [HTTPie](https://httpie.io/)

- [TLDR](https://tldr.sh/)

- [Diagrams.net](https://app.diagrams.net/)

- [Markdown <img src="https://markdowneditor.org/images/favicon-32x32.png" style="vertical-align: middle;">](https://markdowneditor.org)
