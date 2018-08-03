FROM ubuntu

# Copy project files
COPY requirements.system /root
WORKDIR /root

# Install requirements
RUN apt-get update && \
	cat ./requirements.system | xargs apt-get install -y


# Retrieve the code

RUN cd && \
		wget https://api.github.com/repos/KiCad/kicad-source-mirror/tarball/4.0.7 && \
		tar -xzf 4.0.7 && \
		mv ./KiCad-kicad-source-mirror-a29ab39 ./kicad-source-mirror


# Create Makefile

RUN cd kicad-source-mirror && \
	mkdir -p build/	&& \
	cd build/ && \
	bzr whoami "Hugo Jallet <h.jallet@lancey.fr>" && \
	cmake -D KICAD_SPICE=OFF -D KICAD_INSTALL_DEMOS=OFF -D KICAD_USE_OCE=OFF -D KICAD_SCRIPTING_WXPYTHON=OFF -D CMAKE_BUILD_TYPE=Release ../

# Compile

RUN cd kicad-source-mirror/build && \
		make all && \
  	make install && \
		rm -rf kicad-source-mirror

# Tell ldconfig to search in the right folder for shared libraries

RUN ldconfig /usr/local/lib
