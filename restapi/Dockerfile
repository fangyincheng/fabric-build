FROM node:latest
 
RUN mkdir -p /home/www/express
WORKDIR /project/restapi
 
COPY ../ /project
 
RUN npm install -g typescript
RUN npm install
RUN tsc
 
EXPOSE 3000
 
ENTRYPOINT ["npm", "run"]
CMD ["node", "./dist/app.js"]