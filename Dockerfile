FROM ubuntu:16.04

# Copy project files
COPY requirements.system /root
WORKDIR /root

# Install requirements
RUN apt-get update && \
	cat ./requirements.system | xargs apt-get install -y

# Retrieve code
RUN cd && \
	wget https://api.github.com/repos/KiCad/kicad-source-mirror/tarball/5.1.2 && \
	tar -xzf 5.1.2 && \
	mv ./KiCad-kicad-source-mirror-f72e74a ./kicad-source-mirror

# Create Makefile
RUN cd kicad-source-mirror && \
	mkdir -p build/	&& \
	cd build/ && \
	cmake -D KICAD_SPICE=OFF -D KICAD_INSTALL_DEMOS=OFF -D KICAD_USE_OCE=OFF -D KICAD_SCRIPTING_WXPYTHON=OFF -D CMAKE_BUILD_TYPE=Release ../

# Compile
RUN cd kicad-source-mirror/build && \
	make all && \
  	make install && \
	rm -rf kicad-source-mirror

# Go back to root and tell ldconfig to search in the right folder for shared libraries
RUN cd && \
	ldconfig /usr/local/lib

# Delete useless files
RUN rm 5.1.2

