# Golang installation

This bash script installs the latest version og golang for linux based distributions incuding raspberry pi.

Clone the repository to go-install folder and run `go-install.sh`

- Previous installations are removed first
- It installs the latest version of the golang linux distribution
- Go tools are installed for working with for visual code, `gocode`, `golint` to name some.
- Please install the Go extention provided by Google
- Then add the `go-path` file to your $HOME/.profile

```bash
. $HOME/go-install/go-path
```

- A library folder named `golib` and  working folder named `code` are created in the `$HOME` folder
