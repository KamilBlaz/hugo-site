
FROM nginx:alpine as build

RUN apk add --update \
    wget
    
ARG HUGO_VERSION="0.114.0"
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin

COPY ./ /site
WORKDIR /site
RUN hugo --source ./kbsite/ 

EXPOSE 80 1313

CMD ["hugo", "--source", "./kbsite/"]
CMD [ "hugo", "server", "--disableFastRender", "--buildDrafts", "--watch", "--bind", "0.0.0.0", "--baseURL=http://localhost:1313"]

