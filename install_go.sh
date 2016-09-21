#!/bin/bash
set -e
GO="go1.7.1.linux-amd64.tar.gz"

if [ -e ~/go ]; then
    echo 'golang already installed. exit'
    exit 1
fi

echo $GO
wget http://s.gaott.info/$GO

echo 'Check sha256 of go1.6.2.tar'
echo "43ad621c9b014cde8db17393dc108378d37bc853aa351a6c74bf6432c1bbd182 $GO" |  sha256sum --check -

tar xzf $GO
mv -v go ~/
mkdir ~/gos

echo 'Go install finished..'
echo 'Please copy bashrc into $HOME dir to make go work'
echo 'run: go get -u github.com/jstemmer/gotags to install gotags.'
echo 'run: go get -u github.com/rogpeppe/godef to install godef'

rm $GO
