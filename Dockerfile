FROM alpine:latest

RUN apk add --no-cache bash curl

WORKDIR /app
COPY get-nextcloud-cookie.sh .
RUN chmod +x get-nextcloud-cookie.sh

ENTRYPOINT ["/app/get-nextcloud-cookie.sh"]
