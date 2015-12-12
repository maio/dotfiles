FROM ubuntu:14.04
MAINTAINER Marian Schubert <marian.schubert@gmail.com>

RUN echo "deb http://ppa.launchpad.net/ubuntu-elisp/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/emacs.list
RUN apt-get update
RUN apt-get install --yes --force-yes emacs-snapshot-nox wget unzip make git
RUN wget https://github.com/maio/dotfiles/archive/master.zip
RUN unzip master.zip
RUN make -C dotfiles-master install update

CMD ["bash"]
