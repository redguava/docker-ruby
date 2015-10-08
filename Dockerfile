FROM centos:7

# Skip installing gem documentation
RUN echo -e 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc"

# Install dependencies
RUN yum install -y git readline-devel

# Install ruby dependencies
RUN yum install --enablerepo=centosplus -y gcc gcc-c++ libffi-devel make openssl-devel

# Install gem dependencies
RUN yum install -y libxml2 libxml2-devel libxslt libxslt-devel

# Install postgres-client
RUN yum localinstall -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN yum install -y postgresql93-devel
ENV PATH /usr/pgsql-9.3/bin:$PATH

# Install ruby
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/src/ruby-build && \
    cd /usr/local/src/ruby-build && \
    ./install.sh && \
    CONFIGURE_OPTS="--disable-install-doc" ruby-build 2.1.6 /usr/local && \
    rm -rf /usr/local/src/ruby-build

# Install bundler
RUN gem install bundler
