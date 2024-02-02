# Zippy

`zippy` is a zip script written in Bash. The CLI has options to allow zipping, zipping & encrypting as well as unzipping directories.

## Usage

```
zippy.sh [OPTION]
```

If no option is provided Zippy will ask the user if each file should be included

```
Include README.md? (Y/n):
```

### Options (flags)

- `-a`: Includes all files within the current working directory in the zip directory
- `-e`: Encrypts the zip directory
- `-h`: Displays help message
- `-u [TARGET]`: Unzips the `[TARGET]` into the current working directory
