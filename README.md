# make-toolbox

Personal reusable Makefile toolbox.

> **Warning**
>
> Clone this project as `~/.make`.
> Lots of commands depends of this configuration.

## .env files

This toolbox needs some informations into your project `.env` file.

Be sure to have the required variables for each imported Makefile.

## Angular

For Angular projects, initialise your project Makefile with this command :

```shell
cp ~/.make/templates/angular/* .
```

Angular Makefile needs these env. properties (into `.env`) :

| Variable       | Required | Description                                       | Example                          |
| -------------- | -------- | ------------------------------------------------- | -------------------------------- |
| `PROJECT_NAME` | Yes      | Angular project name used for build output paths. | `chinto-fr`                      |
| `FTP_HOST`     | Yes      | FTP server hostname used by deployment scripts.   | `ftp.cluster121.hosting.ovh.net` |
| `FTP_USER`     | Yes      | FTP username used for deployment.                 | `myprojectftp`                   |
| `FTP_PASSWORD` | Yes      | FTP password used for deployment.                 | `********`                       |
| `FTP_PATH`     | Yes      | Remote deployment directory on the FTP server.    | `/home/myproject/www`            |
