### Golang related projects

Just open this folder in vscode and let it be opened in the dev container.

### Working with arrays

Simple array iteration, sort and manipulation.

### Working with strings

Handling strings in golang.

### Basic rest api

This is a Simple REST API web application in golang with 2 endpoints:

- /hello
- /headers

#### Build for RaspberryPi

For RaspberryPi we have to build for arm architecture using arm7, this can be set as environment variables before running the build command:

```bash
user@host1:~$ env GOOS=linux GOARCH=arm GOARM=7 go build hello.go
```

Then we copy the executable to raspberrypi:

```bash
user@host1:~$ scp ./hello pi@raspberrypi:/home/pi
```

then run ./hello and check the service using curl from wsl command line:

```bash
user@host1:~$ curl http://<your-raspi-ip>:8090/headers
```

#### Building without debug files

In order to reduce the size of compiled golang build, we could pass the following build arguments for building a smaller size by excluding debug information.

```bash
go build -ldflags "-s -w" ./hello.go
```

It reduces the size of ./hello by 30%.
