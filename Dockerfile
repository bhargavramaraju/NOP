FROM maven:3.9.4-amazoncorretto-17 AS stage1
LABEL name="bhargavvegesna1997@gmail.com"
COPY . /springpetclinic
WORKDIR /springpetclinic
RUN mvn package

FROM amazoncorretto:17-alpine3.17
ARG USERNAME=petclinic
ARG HOMEDIRECTORY=/pettclinic
RUN adduser --home ${HOMEDIRECTORY} --shell /bin/bash --disabled-password --gecos GECOS ${USERNAME}
USER ${USERNAME}
WORKDIR ${HOMEDIRECTORY}
COPY --from=stage1 --chown=petclinic:petclinic /springpetclinic/target/spring-petclinic-3.1.0-SNAPSHOT.jar ${HOMEDIRECTORY}
EXPOSE 8080
CMD ["java","-jar","spring-petclinic-3.1.0-SNAPSHOT.jar"]
