import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "2.5.6"
    id("io.spring.dependency-management") version "1.0.11.RELEASE"
    war
    kotlin("jvm") version "1.5.31"
    kotlin("plugin.spring") version "1.5.31"
}

group = "com.formskorea"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_11

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-mail")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("com.auth0:java-jwt:3.13.0")
    implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:1.3.2")
    implementation("org.mariadb.jdbc:mariadb-java-client:1.3.2")
    implementation("org.json:json:20180130")
    implementation("org.bgee.log4jdbc-log4j2:log4jdbc-log4j2-jdbc4.1:1.16")
    implementation("com.google.code.gson:gson:2.8.5")
    implementation("org.json:json:20211205")
    implementation("commons-io:commons-io:2.6")
    implementation("javax.servlet:jstl:1.2")
    implementation("org.apache.tomcat.embed:tomcat-embed-jasper")
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
    testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "11"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
