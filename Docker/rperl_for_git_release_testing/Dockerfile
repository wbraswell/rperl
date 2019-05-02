FROM buildpack-deps:stretch-curl
LABEL maintainer=bruce.gray@acm.org

# These packages are prerequisites for RPerl or Pluto.
# Packages named `lib*-perl` are CPAN modules, which install more cleanly
# (and quickly) as packages than via `cpanm`.
# XXX Had to add back in these three Perl modules:
#     libtest-object-perl
#     libtest-subcalls-perl
#     libmodule-refresh-perl
# because of bugs installing them with the recent Perl that has no `.` in @INC:
# https://rt.cpan.org/Public/Bug/Display.html?id=120413
#     Bug #120413 for Test-Object: Fails install when no '.' in @INC
# https://rt.cpan.org/Public/Bug/Display.html?id=120411
#     Bug #120411 for Test-SubCalls: Fails install when no '.' in @INC
# https://rt.cpan.org/Public/Bug/Display.html?id=120812
#     Bug #120812 for Module-Refresh: Fails install when no '.' in @INC
# We may see RPerl failures in CPAN testers on perl-5.26.0+ until these bugs are fixed.
# XXX Check to see what they cause to be installed!
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
     libtest-object-perl \
     libtest-subcalls-perl \
     libmodule-refresh-perl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# XXX Not currently checking the Alien:: stuff; could allow them to install from scratch!


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


# Main software we are installing; all the above was just to support this.
# Note that 30 minutes of build time is in the t/{09,12,13}* tests.
RUN eval $(perl -Mlocal::lib) && cpanm -v RPerl

CMD ["bash"]
