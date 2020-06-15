# Use official image as a parent image.
FROM openjdk:8

#Set the working directory
WORKDIR /usr/src/app

# Run the command inside the image filesystem
RUN apt-get update && apt-get -y upgrade && apt-get -y install curl

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
#RUN echo "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 83.0.4103.39
ENV CHROMEDRIVER_DIR /chromedrivers
RUN mkdir $CHROMEDRIVER_DIR
#
# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver_linux64.zip -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# TODO Copy the app's source code from your host to your file imagesystem.
COPY ./ ./
# COPY ./dockerEntryPoint.sh /

# Entrypoint is in the SH fiile
ENTRYPOINT ["./dockerEntryPoint.sh"]

