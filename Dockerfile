FROM alpine:3 AS stage1
LABEL name="bhargavvegesna1997@gmail.com"
ARG DOWNLOAD_URL="https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.4/nopCommerce_4.60.4_NoSource_linux_x64.zip"
RUN mkdir nopCommerce
WORKDIR nopCommerce
ADD ${DOWNLOAD_URL} /nopCommerce/nopCommerce_4.60.4_NoSource_linux_x64.zip
RUN apk update && \
    apk add unzip && \
    unzip nopCommerce_4.60.4_NoSource_linux_x64.zip

FROM mcr.microsoft.com/dotnet/sdk:7.0
COPY --from=stage1 /nopCommerce /bhargav
WORKDIR /bhargav
ENV ASPNETCORE_URLS="http://0.0.0.0:5000"
CMD ["dotnet","Nop.Web.dll"]
EXPOSE 5000
