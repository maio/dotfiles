FROM ubuntu:15.10
MAINTAINER Marian Schubert <marian.schubert@gmail.com>

RUN apt-get install --yes emacs24-nox wget unzip make git
# RUN apt-get install emacs24-nox unzip make git
RUN wget https://github.com/maio/dotfiles/archive/master.zip
RUN unzip master.zip
RUN make -C dotfiles-master install update

CMD ["bash"]
