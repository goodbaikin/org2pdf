FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive

ADD init.el /root/.emacs.d/init.el
ADD load-melpa.el /root/.emacs.d/load-melpa.el
ADD org2pdf /usr/local/bin/org2pdf

RUN set -xe && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends\
        texlive-lang-japanese \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-plain-generic \
        emacs-nox && \
    apt autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/org2pdf && \
    emacs --batch --load=/root/.emacs.d/load-melpa.el --eval="(package-refresh-contents)" && \
    emacs --batch --load=/root/.emacs.d/load-melpa.el --eval "(package-install 'org-plus-contrib)"
