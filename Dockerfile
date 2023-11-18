FROM debian:bullseye

# GHIDRA depedencies && misc.
RUN apt update && apt install wget -y \
                                make \
                                gcc \
                                g++ \
                                openjdk-17-jdk \
                                gradle \
                                nasm \
                                gdb \
                                unzip \
                                xxd \
                                bsdmainutils \
                                vim \
                                python \
                                gcc-multilib

#RUN  wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.4_build/ghidra_10.4_PUBLIC_20230928.zip &&   \
#        unzip ghidra_10.4_PUBLIC_20230928.zip && \
#        rm -f ghidra_10.4_PUBLIC_20230928.zip

RUN echo "alias l='ls -lah'" >> ~/.bashrc

#CMD cd ghidra_10.4_PUBLIC/