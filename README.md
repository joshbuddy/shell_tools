# ShellUtils

Some common shell utilities.

## sh

Execute the command and return the output. The stderr and stdout are merged together into the output. If it exits with a non-zero status, this method will raise an error.

## sh_with_code

Execute the command and return the output and status code. The stderr and stdout are merged together into the output

## escape

Escapes any number of words and joins them into an escaped string.
