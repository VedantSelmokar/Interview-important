# Use the official Ubuntu as a parent image
FROM ubuntu:latest

# Update the package list and install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx index.html file
RUN rm -f /var/www/html/index.nginx-debian.html

# Copy custom static files or configuration (optional)
COPY ./index.html /var/www/html/

# Expose port 80 to allow web traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]




FROM ubuntu:latest
RUN apt-get update && apt-get install -y nginx
RUN rm -f /var/www/html/index.nginx-debian.html
COPY ./index.html /var/www/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
