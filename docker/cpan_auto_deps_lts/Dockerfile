# VERSION=0.005_000
FROM buildpack-deps:stable-curl AS builder
LABEL maintainer=wbraswell_docker@nym.hush.com

# these packages are prerequisites for RPerl or Pluto;
# packages named `lib*-perl` are CPAN modules, which install more cleanly
# (and quickly) as packages than via `cpanm`;
# NEED FIX: Had to add back in these three Perl modules:
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
# we may see RPerl failures in CPAN testers on perl-5.26.0+ until these bugs are fixed;
# NEED FIX: check to see what they cause to be installed

RUN set -x \
 && apt-get update \
 && apt-get --yes install --no-install-recommends apt-utils \
 && apt-get --yes install --no-install-recommends \
# Perl requirements
    perl \
    cpanminus \
    make \
    perl-debug \
    git \
    curl \
    file \
# RPerl requirements
    g++ \
    libc6-dev \
    libperl-dev \
    libssl-dev \
    zlib1g \
    zlib1g-dev \
    libgmp10 \
    libgmpxx4ldbl \
    libgmp-dev \
    libgsl-dev \
    gsl-bin \
    texinfo \
    flex \
    bison \
    astyle \
# MongoDB requirements
    pkg-config \
    libbson-1.0-0 \
    libbson-dev \
    libmongoc-1.0-0 \
    libmongoc-dev \
# Perl libraries & utilities installed via APT instead of CPAN
    perltidy \
    libpcre2-dev \
    libperl-dev \
    libssl-dev \
    libtest-object-perl \
    libtest-subcalls-perl \
    libmodule-refresh-perl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# NEED UPDATE: Not currently checking the Alien:: stuff; could allow them to install from scratch

# build, install, and clean-up Pluto,
# the automatic polyhedral parallelizer and locality optimizer
RUN mkdir /root/pluto_build \
 && cd    /root/pluto_build \
 && curl -fsSLO https://github.com/bondhugula/pluto/files/737550/pluto-0.11.4.tar.gz \
 && tar zxf pluto-0.11.4.tar.gz \
 && rm      pluto-0.11.4.tar.gz \
 && (cd     pluto-0.11.4 && ./configure && make && make test && make install) \
 && cd /root \
 && rm -rf /root/pluto_build

# create unprivileged user, and set to use local::lib
RUN useradd --create-home --shell /bin/bash rperluser \
 && echo 'eval $( perl -Mlocal::lib )' >> ~rperluser/.bashrc

# needed for local::lib
RUN mkdir perl5

# RPerl is the main software we are installing; all the above was just to support this;
# Start a new stage to prevent the build artifacts from propagating to the final stage
FROM builder AS builder-rperl
# note that 30 minutes of build time is in the t/{09,12,13}* tests
# NEED FIX: Test-utf8 is missing dependency Module::Install    https://github.com/2shortplanks/Test-utf8/issues/7
RUN eval $(perl -Mlocal::lib) && cpanm -v Module::Install && cpanm -n RPerl@5.002000

# Start a new stage based on the initial stage1 build thus omitting the rperl build artifacts
FROM builder

# Copy the files installed by rperl to our final stage
COPY --from=builder-rperl /root/perl5 /home/rperluser/perl5
WORKDIR /home/rperluser/
RUN chown -R rperluser:rperluser /home/rperluser/perl5
USER rperluser:rperluser

# Install example applications
RUN git clone https://github.com/wbraswell/physicsperl.git \
    && cd physicsperl \
    && eval $(perl -Mlocal::lib) \
    && perl Makefile.PL \
    && make && make test && make install \
    && cd .. && rm -rf physicsperl

RUN git clone https://github.com/wbraswell/mathperl.git \
    && cd mathperl \
    && eval $(perl -Mlocal::lib) \
    && perl Makefile.PL \
    && make && make test && make install \
    && cd .. && rm -rf mathperl

RUN eval $(perl -Mlocal::lib) && cpanm MLPerl


# default environmental variables: enable RPerl debug & verbose output;
# CORRELATION #rp140: include current directory '.' in PATH to enable RPerl binary execution after compile

ENV RPERL_DEBUG=1
ENV RPERL_VERBOSE=1
ENV PATH=".:${PATH}"

CMD ["bash"]
