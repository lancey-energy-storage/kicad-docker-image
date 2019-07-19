#########
# BUILD #
#########

FROM ubuntu:18.04 AS builder

# Copy project files
WORKDIR /root
COPY requirements.build .

# Install requirements
RUN apt-get update && \
	cat ./requirements.build | xargs apt-get install -y

# Retrieve code
RUN wget https://api.github.com/repos/KiCad/kicad-source-mirror/tarball/5.1.2 && \
	tar -xzf 5.1.2 && \
	mv ./KiCad-kicad-source-mirror-f72e74a ./kicad-source

# Create Makefile
RUN mkdir -p kicad-source/build/ && \
	cd kicad-source/build/ && \
	cmake -D KICAD_SPICE=OFF -D KICAD_INSTALL_DEMOS=OFF -D KICAD_USE_OCE=OFF -D KICAD_SCRIPTING_WXPYTHON=OFF -D CMAKE_BUILD_TYPE=Release ../

# Compile
RUN cd kicad-source/build/ && \
	make all && \
	make install

#######
# RUN #
#######

FROM ubuntu:18.04 AS runner

# Copy project files
WORKDIR /root
COPY requirements.run .

# Install kicad dependencies
RUN apt-get update && \
	cat ./requirements.run | xargs apt-get install -y

# Copy kicad files
COPY --from=builder /usr/local/ /usr/local/

# Configure and clean stuff
RUN ln -s /usr/bin/python2.7 /usr/bin/python && \
	rm requirements.run && \
	ldconfig /usr/local/lib

# Default command
CMD ["bash"]

