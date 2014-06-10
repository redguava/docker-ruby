FROM redguava/centos

RUN yum install -y readline-devel
RUN yum install -y gcc gcc-c++ openssl-devel
RUN yum install -y git
RUN yum install -y libxml2 libxml2-devel libxslt libxslt-devel postgresql-devel ImageMagick-devel ImageMagick-c++-devel
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN mkdir -p ~/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && source /etc/profile.d/rbenv.sh
RUN bash -lc 'CONFIGURE_OPTS="--disable-install-doc" ~/.rbenv/plugins/ruby-build/bin/ruby-build 2.1.1 ~/.rbenv/versions/2.1.1'
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -lc 'rbenv global 2.1.1; gem install bundler; rbenv rehash'
RUN git clone https://github.com/aripollak/rbenv-bundler-ruby-version.git ~/.rbenv/plugins/rbenv-bundler-ruby-version
