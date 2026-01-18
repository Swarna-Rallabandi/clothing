FROM node:14
ARG SRC_DIR=/opt/i27
# Create a directory inside the container
RUN mkdir -p $SRC_DIR

# Set the working directory inside the container 
WORKDIR $SRC_DIR


# Copy the current content to /opt/i27/ 
COPY . $SRC_DIR



# Install node.js dependencies
RUN npm install 

# Expose the port
EXPOSE 3000 

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# make the entrypoint as executable
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]