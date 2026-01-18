FROM node:14
ARG SRC_DIR=/opt/i27
#create a directory inside the container
RUN mkidir -p $SRC_DIR

#set the working directory inside the container
WORKDIR $SRC_DIR

#copy current content to /opt/i27/
COPY . $SRC_DIR

# install  node.js dependencies
RUN npm install

#expose the port
EXPOSE 3000

#copy enterypoint script
COPY entrypoint.sh /entrypoint.sh

#make the entrypoint as exexuteable
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

