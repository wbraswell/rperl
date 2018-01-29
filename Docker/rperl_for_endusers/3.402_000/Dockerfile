FROM buildpack-deps:stretch-curl
LABEL maintainer=bruce.gray@acm.org

# When building from scratch:
#   docker build -t rperl-image .
#   docker run --name rperl_instance -ti rperl-image
# After this has been loaded onto the Docker Hub, a much faster command will be available.

# These packages are prerequisites for RPerl or Pluto.
# Packages named `lib*-perl` are CPAN modules, which install more cleanly
# (and quickly) as packages than via `cpanm`.
RUN set -x \
 && apt-get update \
 && apt-get --yes install --no-install-recommends apt-utils \
 && apt-get --yes install --no-install-recommends \
     astyle \
     bison \
     cpanminus \
     file \
     flex \
     g++ \
     gcc \
     git \
     make \
     perltidy \
     texinfo \
     libc6-dev \
     gsl-bin \
     libgsl-dev \
     libgmp-dev \
     libpcre2-dev \
     libperl-dev \
     libssl-dev \
     zlib1g-dev \
 && apt-get --yes install --no-install-recommends \
     libalgorithm-diff-perl \
     libalgorithm-diff-xs-perl \
     libarchive-extract-perl \
     libcapture-tiny-perl \
     libcpan-changes-perl \
     libextutils-cppguess-perl \
     libfile-chdir-perl \
     libinline-c-perl \
     libinline-perl \
     libio-socket-ssl-perl \
     libipc-run3-perl \
     liblocal-lib-perl \
     libmath-bigint-gmp-perl \
     libmodule-load-conditional-perl \
     libmodule-refresh-perl \
     libmodule-runtime-perl \
     libmodule-scandeps-perl \
     libmro-compat-perl \
     libpadwalker-perl \
     libparse-yapp-perl \
     libperl-critic-perl \
     libpkgconfig-perl \
     libpod-pseudopod-perl \
     libscalar-list-utils-perl \
     libscope-guard-perl \
     libsort-versions-perl \
     libtest-class-perl \
     libtest-deep-perl \
     libtest-differences-perl \
     libtest-exception-perl \
     libtest-most-perl \
     libtest-number-delta-perl \
     libtest-simple-perl \
     libtest-taint-perl \
     libtest-warn-perl \
     libtest2-perl \
     libtext-asciitable-perl \
     libtext-diff-perl \
     libtimedate-perl \
     libtry-tiny-perl \
 && apt-get --yes install --no-install-recommends \
     less \
     vim-tiny \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build, install, and clean-up Pluto,
# the automatic polyhedral parallelizer and locality optimizer.
RUN mkdir /root/pluto_build \
 && cd    /root/pluto_build \
 && curl -fsSLO https://github.com/bondhugula/pluto/files/737550/pluto-0.11.4.tar.gz \
 && tar zxf pluto-0.11.4.tar.gz \
 && rm      pluto-0.11.4.tar.gz \
 && (cd     pluto-0.11.4 && ./configure && make && make test && make install) \
 && cd /root \
 && rm -rf /root/pluto_build

# Create unprivileged user, and set to use local::lib
RUN useradd --create-home --shell /bin/bash rperl \
 && echo 'eval $( perl -Mlocal::lib )' >> ~rperl/.bashrc

USER rperl:rperl
WORKDIR /home/rperl/

# Needed for local::lib
RUN mkdir perl5


# While the `cpanm -v RPerl` command that runs later will load the same
# pre-requisites as this line, this line exists to move known pre-reqs
# into another layer of Docker. The modules are ordered to reduce found
# dependencies.
RUN eval $(perl -Mlocal::lib) && cpanm \
     Math::GSL \
     Importer \
     Test2::Tools::Tiny \
     Term::Table \
     Sub::Info \
     Test2 \
     Test2::Mock \
     FFI::CheckLib \
     PkgConfig \
     Shell::Guess \
     Shell::Config::Generate \
     Alien::Build \
     Alien::Base::ModuleBuild \
     Env::ShellWords \
     Parse::Yapp \
     Parse::Eyapp \
     Alien::gmake \
     Alien::PCRE2 \
     Alien::JPCRE2 \
     App::Pod2CpanHtml \
     Inline::CPP \
     Inline::Filters \
     Perl::Tidy \
     Alien::astyle

# Main software we are installing; all the above was just to support this.
# Note that 30 minutes of build time is in the t/{09,12,13}* tests.
RUN eval $(perl -Mlocal::lib) && cpanm -v RPerl

# Copy examples from the RPerl book to a hackable location.
# RUN cp -irp /usr/local/share/perl/5.24.1/RPerl/Learning/ .
RUN cp -irp /home/rperl/perl5/lib/perl5/RPerl/Learning/ .

RUN echo "See http://rperl.org/learning/ for full text of the book 'Learning RPerl: The Official Introductory-Level Reference, User Manual, and Educational Documentation for Restricted Perl, The Optimizing Perl 5 Compiler'." \
  > README

CMD ["bash"]
