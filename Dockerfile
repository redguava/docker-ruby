FROM redguava/centos

# Install readline
RUN yum install -y readline-devel

# Install ruby dependencies
RUN yum install -y gcc gcc-c++ openssl-devel

# Install cliniko dependencies
RUN yum install -y libxml2 libxml2-devel libxslt libxslt-devel ImageMagick-devel ImageMagick-c++-devel
RUN yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum install postgresql93-devel

# Install ruby
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN mkdir -p ~/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && source /etc/profile.d/rbenv.sh
RUN bash -lc 'CONFIGURE_OPTS="--disable-install-doc" ~/.rbenv/plugins/ruby-build/bin/ruby-build 2.1.1 ~/.rbenv/versions/2.1.1'
RUN bash -lc 'rbenv global 2.1.1'

# Configure gem installation
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

# Install bundler
RUN bash -lc 'gem install bundler; rbenv rehash'

# Automatically set ruby version based on Gemfile
RUN git clone https://github.com/aripollak/rbenv-bundler-ruby-version.git ~/.rbenv/plugins/rbenv-bundler-ruby-version
