#!/bin/bash

: '
  Multi comment example
  :D
'

: '
# Example on: How to curl a list of private repositories at github if they are invisible and you need to login:
  curl \
      -u "username:password" \
      -X GET \
      https://mygithuburl.com/user/repos?visibility=private
'

# At the HTML text, all repos have "codeResoritory" written in the same line, you can grep by that first
