FROM redguava/centos

# Install readline
RUN yum install -y readline-devel

# Install ruby dependencies
RUN yum install --enablerepo=centosplus -y gcc gcc-c++ openssl-devel

# Install gem dependencies
RUN yum install -y libxml2 libxml2-devel libxslt libxslt-devel make

# Install postgres-client
RUN yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum install -y postgresql93-devel
RUN echo -e 'export PATH=/usr/pgsql-9.3/bin:$PATH' >> /etc/profile.d/pg.sh

# Install ruby
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN mkdir -p ~/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo -e 'export PATH=~/.rbenv/bin:$PATH\neval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN bash -lc 'CONFIGURE_OPTS="--disable-install-doc" ~/.rbenv/plugins/ruby-build/bin/ruby-build 2.1.2 ~/.rbenv/versions/2.1.2'
RUN bash -lc 'rbenv global 2.1.2'

# Configure gem installation
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

# Install bundler
RUN bash -lc 'gem install bundler; rbenv rehash'

# Automatically set ruby version based on Gemfile
RUN git clone https://github.com/aripollak/rbenv-bundler-ruby-version.git ~/.rbenv/plugins/rbenv-bundler-ruby-version
