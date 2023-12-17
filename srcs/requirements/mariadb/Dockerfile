FROM alpine

RUN apk update && apk add --no-cache neofetch

COPY ./tools/init.sh ./init.sh

CMD [ "neofetch". "", "" ]
