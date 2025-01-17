#Customizing Ubuntu Base Image

FROM ubuntu:22.04

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    
RUN rm -rf /var/lib/apt/lists/*

# Set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Default command
CMD ["bash"]
