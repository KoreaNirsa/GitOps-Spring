# ---- build stage ----
FROM gradle:9.3-jdk21 AS build
WORKDIR /GitOps
COPY . .
RUN gradle clean bootJar -x test

# ---- run stage ----
FROM eclipse-temurin:21-jre
WORKDIR /GitOps
COPY --from=build /GitOps/build/libs/*.jar demo.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/GitOps/GitOps.jar"]



