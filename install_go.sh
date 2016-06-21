#!/bin/bash
set -e
GO="go1.6.2.linux-amd64.tar.gz"

if [ -e ~/go ]; then
    echo 'golang already installed. exit'
    exit 1
fi

echo 'Downloading go1.6.2 tar..'
wget http://s.gaott.info/$GO

echo 'Check sha256 of go1.6.2.tar'
echo "e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a $GO" |  sha256sum --check - 

tar xzf $GO
mv -v go ~/
mkdir ~/gos

echo 'Please copy bashrc into $HOME dir to make go work'

rm $GO
